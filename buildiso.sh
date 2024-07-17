#!/usr/bin/env bash
nix build .#nixosConfigurations.default.config.system.build.isoImage
