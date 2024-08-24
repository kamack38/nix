#!/bin/sh

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

# Save LUKS password to file
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
echo -n "${luks_password}" >  /tmp/secret.key

# Run disko
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko-config.nix --arg device "\"$1\"" 2>&1 | tee disko-output.log
sudo nixos-generate-config --no-filesystems --root /mnt
sudo cp ./conf.nix /mnt/etc/nixos/configuration.nix
sudo cp ./disko-config.nix /mnt/etc/nixos/disko-config.nix
