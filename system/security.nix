{ lib, ... }: {
  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults pwfeedback,insults";
    lockKernelModules = lib.mkDefault true;
    protectKernelImage = lib.mkDefault true;
    pam.services."system-login".failDelay = {
      enable = true;
      delay = 4000000;
    };
  };

  # enable firejail
  # programs.firejail.enable = true;
  #
  # # create system-wide executables firefox and chromium
  # # that will wrap the real binaries so everything
  # # work out of the box.
  # programs.firejail.wrappedBinaries = {
  #     firefox = {
  #         executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
  #         profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
  #     };
  #     chromium = {
  #         executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
  #         profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
  #     };
  # };
}
