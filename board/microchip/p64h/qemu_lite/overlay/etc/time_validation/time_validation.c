#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <string.h>

/* RISC-V CSR definitions for timer access */
#define CSR_CYCLE    0xc00  /* Cycle counter (read-only) */
#define CSR_TIME     0xc01  /* Time counter (read-only) */
#define CSR_INSTRET  0xc02  /* Instructions retired (read-only) */

/* Inline assembly macros to read RISC-V CSRs */
#define read_csr(csr) ({                           \
    uint64_t __tmp;                                \
    asm volatile ("csrrs %0, %1, x0"               \
                  : "=r" (__tmp)                   \
                  : "i" (csr));                    \
    __tmp;                                         \
})

static inline uint64_t rdcycle(void) {
    uint64_t cycles;
    asm volatile ("rdcycle %0" : "=r" (cycles));
    return cycles;
}

static inline uint64_t rdtime(void) {
    uint64_t time;
    asm volatile ("rdtime %0" : "=r" (time));
    return time;
}

static inline uint64_t rdinstret(void) {
    uint64_t instret;
    asm volatile ("rdinstret %0" : "=r" (instret));
    return instret;
}

/* Busy-loop function for controlled cycle measurement */
static void busy_loop_cycles(uint64_t target_cycles) {
    uint64_t start = rdcycle();
    while (rdcycle() - start < target_cycles) {
        /* Volatile operation to prevent loop optimization */
        asm volatile ("nop");
    }
}

/* Measure frequency of cycle counter relative to system time */
typedef struct {
    uint64_t cycle_start;
    uint64_t cycle_end;
    uint64_t time_start;
    uint64_t time_end;
    struct timespec monotonic_raw_start;
    struct timespec monotonic_raw_end;
    double cycle_freq_hz;
    double time_freq_hz;
    double actual_freq_hz;
    double cycle_period_ns;
    double time_period_ns;
} TimerMeasurement;

void measure_timers(TimerMeasurement *meas, uint64_t measurement_duration_cycles) {
    /* Get initial timestamps */
    clock_gettime(CLOCK_MONOTONIC_RAW, &meas->monotonic_raw_start);
    meas->cycle_start = rdcycle();
    meas->time_start = rdtime();

    /* Busy loop for precise cycle-based duration */
    busy_loop_cycles(measurement_duration_cycles);

    /* Get final timestamps */
    meas->cycle_end = rdcycle();
    meas->time_end = rdtime();
    clock_gettime(CLOCK_MONOTONIC_RAW, &meas->monotonic_raw_end);

    /* Calculate deltas */
    uint64_t cycle_delta = meas->cycle_end - meas->cycle_start;
    uint64_t time_delta = meas->time_end - meas->time_start;

    uint64_t mono_raw_ns_start = (meas->monotonic_raw_start.tv_sec * 1000000000ULL) +
                                 meas->monotonic_raw_start.tv_nsec;
    uint64_t mono_raw_ns_end = (meas->monotonic_raw_end.tv_sec * 1000000000ULL) +
                               meas->monotonic_raw_end.tv_nsec;
    uint64_t mono_raw_ns_delta = mono_raw_ns_end - mono_raw_ns_start;

    /* Convert nanoseconds to seconds for frequency calculation */
    double mono_raw_seconds = mono_raw_ns_delta / 1e9;

    if (mono_raw_seconds > 0) {
        meas->actual_freq_hz = cycle_delta / mono_raw_seconds;
        meas->cycle_period_ns = (mono_raw_ns_delta * 1000.0) / cycle_delta;
    }

    if (time_delta > 0 && mono_raw_seconds > 0) {
        meas->time_freq_hz = time_delta / mono_raw_seconds;
        meas->time_period_ns = (mono_raw_ns_delta * 1000.0) / time_delta;
    }
}

void print_measurement(const TimerMeasurement *meas, const char *label,
                      uint64_t measurement_cycles) {
    printf("\n=== %s ===\n", label);
    printf("Measurement duration (requested cycles): %lu\n", measurement_cycles);
    printf("\nRaw Counter Values:\n");
    printf("  Cycle counter start:        %20lu\n", meas->cycle_start);
    printf("  Cycle counter end:          %20lu\n", meas->cycle_end);
    printf("  Cycle counter delta:        %20lu\n", meas->cycle_end - meas->cycle_start);
    printf("\n  Time counter start:         %20lu\n", meas->time_start);
    printf("  Time counter end:           %20lu\n", meas->time_end);
    printf("  Time counter delta:         %20lu\n", meas->time_end - meas->time_start);

    printf("\nMonotonic Raw Clock (CLOCK_MONOTONIC_RAW):\n");
    printf("  Start: %lu.%09lu seconds\n", meas->monotonic_raw_start.tv_sec,
           meas->monotonic_raw_start.tv_nsec);
    printf("  End:   %lu.%09lu seconds\n", meas->monotonic_raw_end.tv_sec,
           meas->monotonic_raw_end.tv_nsec);

    uint64_t mono_ns_delta = ((meas->monotonic_raw_end.tv_sec - meas->monotonic_raw_start.tv_sec) * 1000000000ULL)
                           + (meas->monotonic_raw_end.tv_nsec - meas->monotonic_raw_start.tv_nsec);
    printf("  Delta: %lu nanoseconds (%.9f seconds)\n", mono_ns_delta, mono_ns_delta / 1e9);

    printf("\nDerived Frequencies:\n");
    printf("  Cycle counter frequency:   %.2f Hz\n", meas->actual_freq_hz);
    printf("  Time counter frequency:    %.2f Hz\n", meas->time_freq_hz);
    printf("\nDerived Periods:\n");
    printf("  Cycle period:              %.3f nanoseconds (%.3f picoseconds)\n",
           meas->cycle_period_ns, meas->cycle_period_ns * 1000.0);
    printf("  Time period:               %.3f nanoseconds (%.3f picoseconds)\n",
           meas->time_period_ns, meas->time_period_ns * 1000.0);

    /* Calculate what the frequency would be if 1GHz assumption held */
    printf("\nCalibration vs 1GHz Assumption:\n");
    printf("  Assumed freq:              1000000000.00 Hz\n");
    printf("  Measured freq:             %.2f Hz\n", meas->actual_freq_hz);
    printf("  Error from 1GHz:           %.6f%%\n",
           ((meas->actual_freq_hz - 1e9) / 1e9) * 100.0);
}

int main(void) {
    printf("HPSC Timer Calibration Utility\n");
    printf("=========================================================\n");

    /* Test parameters - adjust based on measurement requirements */
    uint64_t short_duration = 10000000ULL;    /* 10M cycles (~10ms @ 1GHz) */
    uint64_t long_duration = 100000000ULL;    /* 100M cycles (~100ms @ 1GHz) */
    uint64_t very_long_duration = 1000000000ULL; /* 1B cycles (~1s @ 1GHz) */

    TimerMeasurement meas1, meas2, meas3;

    printf("\nPerforming timer measurements...\n");
    printf("(Each measurement will take ~%lu-1GHz cycles)\n", short_duration);

    /* Short measurement */
    measure_timers(&meas1, short_duration);
    print_measurement(&meas1, "SHORT MEASUREMENT (10M cycles)", short_duration);

    /* Medium measurement */
    measure_timers(&meas2, long_duration);
    print_measurement(&meas2, "MEDIUM MEASUREMENT (100M cycles)", long_duration);

    /* Long measurement */
    measure_timers(&meas3, very_long_duration);
    print_measurement(&meas3, "LONG MEASUREMENT (1B cycles)", very_long_duration);

    /* Summary analysis */
    printf("\n\n=== SUMMARY ANALYSIS ===\n");
    printf("Average cycle counter frequency across measurements:\n");
    double avg_cycle_freq = (meas1.actual_freq_hz + meas2.actual_freq_hz + meas3.actual_freq_hz) / 3.0;
    printf("  %.2f Hz\n", avg_cycle_freq);

    printf("\nAverage time counter frequency across measurements:\n");
    double avg_time_freq = (meas1.time_freq_hz + meas2.time_freq_hz + meas3.time_freq_hz) / 3.0;
    printf("  %.2f Hz\n", avg_time_freq);

    printf("\nTime/Cycle Frequency Ratio:\n");
    if (avg_cycle_freq > 0) {
        printf("  time_freq / cycle_freq = %.6f\n", avg_time_freq / avg_cycle_freq);
    }

    printf("\nInterpretation:\n");
    printf("  - Cycle counter increments once per core clock cycle\n");
    printf("  - Time counter typically increments at fixed frequency (e.g., 10MHz)\n");
    printf("  - CLOCK_MONOTONIC_RAW provides absolute reference to reality\n");
    printf("  - Deviation from 1GHz indicates actual process frequency\n");

    printf("\nTo use these timers in production:\n");
    printf("  1. Use cycle counter for fine-grained cycle-accurate measurements\n");
    printf("  2. Use time counter for absolute wall-clock timing\n");
    printf("  3. Correlate with CLOCK_MONOTONIC_RAW for system synchronization\n");
    printf("  4. Apply calibration factor: measured_freq / assumed_freq\n");

    return 0;
}
