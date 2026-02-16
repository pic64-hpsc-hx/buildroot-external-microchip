# Script to switch into the debian rootfs

# pass an alternate CHROOT_TARGET as the first argument
if [ -z "$1" ]; then
    CHROOT_TARGET="/opt"
else
    CHROOT_TARGET="$1"
fi

# if CHROOT_TARGET is not mounted, mount it
if ! mountpoint -q "$CHROOT_TARGET"; then
    if ! mount -t ext4 /dev/vda1 "$CHROOT_TARGET"; then
        echo "Failed to mount CHROOT_TARGET. Please make sure that the disk image is mounted at /dev/vda1."
        exit 1
    fi
fi

# chroot into CHROOT_TARGET and execute commands

if ! chroot "$CHROOT_TARGET" /bin/bash -c \
    'mount -t proc none /proc && echo "You are now in the chroot environment. To exit, type 'exit'." && cd ~ && exec /bin/bash --rcfile /home/debian/.bashrc'; then
    echo "Failed to chroot into CHROOT_TARGET"
    exit 1
fi

echo "Exited chroot environment"