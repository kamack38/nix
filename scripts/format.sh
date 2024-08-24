#!/usr/bin/env bash

# Exit on error
set -e

# Colours
BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

DISK="$1"

echo "${BLUE}:: ${BWHITE}The selected is ${GREEN}${DISK}${NC}"

# Check if on a bios system
if [[ ! -d "/sys/firmware/efi" ]]; then
	echo "${RED}:: ${BWHITE}You're on an BIOS system aborting...${NC}"
	exit 1
fi
echo "${GREEN}:: ${BWHITE}You're on an UEFI system proceeding...${NC}"

# Create luks password (encryption)
while true; do
	echo -n "${YELLOW}:: ${BWHITE}Please enter your luks password: ${NC}"
	read -rs luks_password # read password without echo

	echo -ne "\n${YELLOW}:: ${BWHITE}Please repeat your luks password: ${NC}"
	read -rs luks_password2 # read password without echo

	if [ "$luks_password" = "$luks_password2" ]; then
		echo -e "\n${GREEN}:: ${BWHITE}Passwords match.${NC}"
		LUKS_PASSWORD="$luks_password"
		break
	else
		echo -e "\n${RED}:: ${BWHITE}Passwords do not match. Please try again.${NC}"
	fi
done

# Make sure everything is unmounted when starting
if grep -qs '/mnt' /proc/mounts; then
	echo "${YELLOW}:: ${BLUE}/mnt${BWHITE} is mounted${NC} -- unmounting"
	umount -AR /mnt
else
	echo "${BLUE}:: ${BLUE}/mnt${BWHITE} is not mounted${NC} -- skipping"
fi

echo "${BLUE}:: ${BWHITE}Rereading partition table...${NC}"
partprobe "${DISK}"

# Create partitions
echo "${BLUE}:: ${BWHITE}Creating partitions...${NC}"
sgdisk -n "0::+300M" --typecode="0:ef00" --change-name="0:EFIBOOT" "${DISK}" # partition 1 (UEFI Boot Partition)
sgdisk -N "0" --typecode="0:8300" --change-name="0:NixOS" "${DISK}"          # partition 1/2 (Root), default start, remaining

# Format boot partition
if [[ $use_x_efi == n* ]]; then
	echo "${BLUE}:: ${BWHITE}Formatting EFI partition...${NC}"
	mkfs.vfat -F32 -n "EFIBOOT" "/dev/disk/by-partlabel/EFIBOOT"
fi

# Enter luks password to cryptsetup and format root partition
echo "${BLUE}:: ${BWHITE}Encrypting root partition...${NC}"
echo -n "${LUKS_PASSWORD}" | cryptsetup -v luksFormat "/dev/disk/by-partlabel/NixOS" -

# Open luks container and ROOT will be place holder
echo "${BLUE}:: ${BWHITE}Opening root partition...${NC}"
echo -n "${LUKS_PASSWORD}" | cryptsetup open "/dev/disk/by-partlabel/NixOS" cryptroot -

# Format luks container
mapper=/dev/mapper/cryptroot
mkfs.btrfs -L root ${mapper}

# Create subvolumes for btrfs
echo "${BLUE}:: ${BWHITE}Creating BTRFS subvolumes...${NC}"
mount ${mapper} /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@swap

# unmount root to remount with subvolume
umount /mnt

echo "${BLUE}:: ${BWHITE}Mounting @ subvolume...${NC}"
mount -o ${MOUNT_OPTIONS},subvol=@ ${mapper} /mnt

echo "${BLUE}:: ${BWHITE}Creating directories (home, nix, tmp, var, swap)...${NC}"
mkdir -p /mnt/{home,var,tmp,swap,nix}

# Set mount options
MOUNT_OPTIONS="noatime,compress=zstd,commit=60"
SWAP_MOUNT_OPTIONS="nodatacow,noatime,commit=60,nospace_cache"

# Mount all btrfs subvolumes
echo "${BLUE}:: ${BWHITE}Mounting other btrfs subvolumes...${NC}"

mount -o ${MOUNT_OPTIONS},subvol=@home ${mapper} /mnt/home
mount -o ${MOUNT_OPTIONS},subvol=@nix ${mapper} /mnt/.snapshots
mount -o ${MOUNT_OPTIONS},nodev,nosuid,subvol=@tmp ${mapper} /mnt/tmp
mount -o ${MOUNT_OPTIONS},subvol=@var ${mapper} /mnt/var
mount -o ${SWAP_MOUNT_OPTIONS},subvol=@swap ${mapper} /mnt/swap

# Mount target
mkdir -p /mnt/boot/efi
mount -t vfat -L EFIBOOT /mnt/boot/
