# NixOS configuration

## Installation

Before formatting the disk make sure that the disk has some empty space.

To clear the WHOLE disk run:

```bash
sgdisk -Z /dev/disk
```

### Formatting disk

To format the disk run:

```bash
./format.sh /dev/disk
```

### Installing NixOS

After formatting the disk, generate the config and run:

```bash
sudo su
git clone https://github.com/kamack38/nixos /mnt/home/kamack38/dotfiles
nix-shell -p git nixUnstable
nixos-generate-config --show-hardware-config>/mnt/home/kamack38/dotfiles/hardware-configuration.nix
nixos-install --flake /mnt/home/kamack38/dotfiles#default
```

The default user is `kamack38` with password `password`

## NixOS information

- [NixOS and flakes guide](https://nixos-and-flakes.thiscute.world)
- [Noogle](https://noogle.dev/)
- [Options](https://search.nixos.org/options?channel=24.05)
- [Packages](https://search.nixos.org/packages?channel=24.05)
- [Nixy](https://github.com/anotherhadi/nixy/blob/main/hosts/laptop/configuration.nix)
- [MyNixOs](https://mynixos.com/)
- [nix.dev](https://nix.dev/)

## TODO

- [ ] Check if playerctl is enabled

- [ ] Fix config
- [ ] Conditional module imports
- [ ] Enabling NixOS options in hm modules

- [x] nh - NixOs helper
- [x] Locales
- [x] Keyboard layout
- [x] TTY colours
- [x] fish
- [x] sudo insults and pw_feedback
- [x] cli programs
  - [x] jq
  - [x] fd
  - [x] dust
  - [x] tealdeer
  - [x] ripgrep
  - [x] bat
  - [x] eza
  - [x] croc
  - [x] fzf
  - [x] btop
  - [x] ffmpeg
- [ ] [Neovim](https://nixos.wiki/wiki/Neovim)
  - [ ] Install LSPs
  - [ ] Install Formatters
  - [ ] Fix following links in Neovim docs 
  - [ ] Harpoon with harpoon-line
  - [ ] Typst inline preview plugin (mathematical equations are separately complied and showed above their code)
  - [ ] rustceanvim
- [x] kitty
- [x] [Yubikey](https://nixos.wiki/wiki/Yubikey)
  - [x] SSH support
  - [x] GnuPG support
- [x] git & delta
- [x] GnuPG
- [x] gh
- [ ] [Firefox](https://nixos.wiki/wiki/Firefox)
  - [x] Config
  - [ ] Addons
    - [x] Vimium or Tridactyl
  - [x] ff2mpv
  - [ ] Search engines
    - [ ] Search suggestions for supported engines
      - [ ] MDN
  - [ ] YouTube different shortcuts (h and l to skip 5 secs)
- [ ] Desktop
  - [ ] [Spotify](https://nixos.wiki/wiki/Spotify) & [spicetify](https://github.com/the-argus/spicetify-nix)
  - [x] Discord
    - [x] Screen sharing support on Wayland via xwaylandvideobridge
  - [x] File manager (dolphin)
  - [ ] Image viewer (gwenview)
  - [ ] Archive viewer (ark)
  - [ ] PDF viewer
  - [ ] GTK Theme
  - [ ] QT Theme
  - [ ] Mime types
- [x] Rust toolchain
- [x] mpv
  - [x] sponsorblock
  - [x] cheatsheet
  - [x] webtorrent-mpv-hook
  - [x] yt-dlp
- [x] mpd & mpris
- [x] playerctld (playerctl daemon)
- [ ] sptlrx
- [ ] Add assets
  - [ ] Dunst
- [ ] Add scripts
  - [ ] Hyprlock
- [ ] Hyprland (with current settings)
  - [x] Hyprlock
  - [x] Hypridle
  - [x] Hyprpaper
  - [ ] waybar
    - [ ] brightnessctl
  - [x] dunst
  - [ ] application launcher (rofi)
  - [ ] screenshots (grimblast)
- [ ] SDDM
  - [ ] Autologin
  - [ ] Plymouth
    - [ ] [adi1090x themes](https://github.com/adi1090x/plymouth-themes/pull/46/files)
    - [ ] GreenLeaf plymouth theme
  - [ ] GreenLeaf Theme
    - [ ] Create theme repo
- [ ] Coursor theme
  - [ ] Hyprcursor (maybe)
  - [ ] Fluent coursor theme
- [ ] Fluent dark icon theme
- [ ] Hardware configuration
  - [ ] Asusctl
  - [ ] Openrazer
  - [ ] Piper
  - [ ] Streamdeck
  - [ ] Nvidia
  - [ ] [Hardware video acceleration](https://nixos.wiki/wiki/Accelerated_Video_Playback)
  - [ ] AMD
- [ ] Performance tweaks
  - [ ] Ananicy-cpp
- [ ] Powersave tweaks (only when not charging)
- [ ] Flatpaks
- [ ] System hardening
  - [ ] rkhunter
  - [ ] lynis
  - [ ] ssh
- [ ] Fonts
  - [ ] kitty
  - [ ] Chainese glyphs support
  - [ ] FiraCode NF
  - [ ] JetBrainsMono NF
- [ ] System-wide spell checking
- [ ] Swap ([Wiki](https://nixos.wiki/wiki/Swap))
- [ ] Hibernation
- [ ] noisetorch
- [ ] Firewall
  - [ ] Secure firewall (all ports blocked)
  - [ ] VPN support
  - [ ] VM support
- [ ] VPN
- [x] Pam delay
- [ ] Libinput
- [ ] Dualscreen on boot
- [x] Home-manager
- [ ] Modules
  - [x] [Docker](https://nixos.wiki/wiki/Docker)
  - [x] Virtual-machines
  - [x] Bluetooth
  - [x] wakatime
  - [ ] Nvidia
  - [ ] Games
  - [ ] Enable modules inside flakes
- [ ] ISO
- [ ] Additional features
  - [ ] Expo dev environment (android studio)
  - [ ] MacOS KVM
  - [Arch Linux tweaks](https://gist.github.com/lbrame/1678c00213c2bd069c0a59f8733e0ee6)
  - [ ] System-wide single colour theme
  - [ ] Kamack38 square plymouth theme
  - [ ] Periodic automatic backups (they send a notification when the backup time has come and send them repeatedly in small time intervals until a thumbdrive containing a certaing directory is connected and the backup completed (in the future switch to homeserver remote backups))
  - [ ] [Package firefox extensions](https://sr.ht/~rycee/mozilla-addons-to-nix/)
  - [ ] Block all newly connected USB devices and easily allow to unblock them
  - [ ] Secure boot ([Secure boot on NixOS with TPM](https://jnsgr.uk/2024/04/nixos-secure-boot-tpm-fde/))
  - [ ] Full typst editing workflow
    - [ ] Typst in NeoVim using [Tinymist](https://github.com/Myriad-Dreamin/tinymist)
  - [ ] LanguageTool
    - [ ] Custom server
    - [ ] NeoVim
  - [ ] Yubikey TOTP code generation
  - [ ] Command/Keybinding to view cheatsheets (NeoVim, Linux)
  - [ ] Sync between android and NixOS
- [ ] Additional programs
  - [ ] Speech recognition ([Whisper](https://github.com/openai/whisper))
    - [ ] Live speech recognition (maybe [WhisperLive](https://github.com/collabora/WhisperLive))
  - [ ] OCR ([surya](https://github.com/VikParuchuri/surya))
    - [ ] Convert PDF with images using OCR
  - [ ] Generate live subtitles for music files
  - [ ] Screen recording
  - [ ] Voice recording
  - [ ] Local GPT assistant that parses files and gives information found in them when asked
    - [ ] [tgpt](https://github.com/aandrew-me/tgpt)
    - [ ] [GPT4All](https://github.com/nomic-ai/gpt4all) or [PrivateGPT](https://github.com/zylon-ai/private-gpt)
  - [ ] Subtitle for movies generation ([subsai](https://github.com/abdeladim-s/subsai))
- [ ] Learn nixos commands
- [ ] Learn how to pin packages (easily)
