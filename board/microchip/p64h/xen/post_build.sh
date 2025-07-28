#!/bin/sh

echo "###### XEN POST BUILD ######"
target_dir="$1"
echo "target_dir=$1"

# rm -rf "$target_dir"/dev/fd
# rm -rf "$target_dir"/dev/input
# rm -rf "$target_dir"/dev/log
# rm -rf "$target_dir"/dev/net
# rm -rf "$target_dir"/dev/pts
# rm -rf "$target_dir"/dev/shm
# rm -rf "$target_dir"/dev/stderr
# rm -rf "$target_dir"/dev/stdin
# rm -rf "$target_dir"/dev/stdout
# rm -rf "$target_dir"/etc/fstab
# rm -rf "$target_dir"/etc/group
# rm -rf "$target_dir"/etc/hostname
# rm -rf "$target_dir"/etc/hosts
# rm -rf "$target_dir"/etc/init.d
# rm -rf "$target_dir"/etc/issue
# rm -rf "$target_dir"/etc/mtab
# rm -rf "$target_dir"/etc/network
# rm -rf "$target_dir"/etc/nsswitch.conf
# rm -rf "$target_dir"/etc/os-release
# rm -rf "$target_dir"/etc/profile.d
# rm -rf "$target_dir"/etc/protocols
# rm -rf "$target_dir"/etc/resolv.conf
# rm -rf "$target_dir"/etc/services
# rm -rf "$target_dir"/etc/shells
rm -rf "$target_dir"/lib/ld-linux-riscv64-lp64d.so.1
rm -rf "$target_dir"/lib/libanl.so.1
rm -rf "$target_dir"/lib/libatomic.so
rm -rf "$target_dir"/lib/libatomic.so.1
rm -rf "$target_dir"/lib/libatomic.so.1.2.0
rm -rf "$target_dir"/lib/libcrypt.so.1
rm -rf "$target_dir"/lib/libc.so.6
rm -rf "$target_dir"/lib/libdl.so.2
rm -rf "$target_dir"/lib/libgcc_s.so
rm -rf "$target_dir"/lib/libgcc_s.so.1
rm -rf "$target_dir"/lib/libm.so.6
rm -rf "$target_dir"/lib/libnss_dns.so.2
rm -rf "$target_dir"/lib/libnss_files.so.2
rm -rf "$target_dir"/lib/libpthread.so.0
rm -rf "$target_dir"/lib/libresolv.so.2
rm -rf "$target_dir"/lib/librt.so.1
rm -rf "$target_dir"/lib/libutil.so.1
rm -rf "$target_dir"/lib/modules
rm -rf "$target_dir"/lib64
rm -rf "$target_dir"/media
rm -rf "$target_dir"/opt
rm -rf "$target_dir"/root
rm -rf "$target_dir"/usr/lib
rm -rf "$target_dir"/usr/lib64
rm -rf "$target_dir"/usr/sbin
rm -rf "$target_dir"/var/cache
rm -rf "$target_dir"/var/lib
rm -rf "$target_dir"/var/lock
rm -rf "$target_dir"/var/log
rm -rf "$target_dir"/var/run
rm -rf "$target_dir"/var/spool
rm -rf "$target_dir"/var/tmp
rm -rf "$target_dir"/var/www
