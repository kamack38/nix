{ config, lib, ... }: {
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };

  config.var = {
    hostname = "nixos";
    username = "kamack38";
    homeDirectory = "/home/" + config.var.username;

    keyboardLayout = "pl";

    timeZone = "Europe/Warsaw";
    defaultLocale = "en_GB.UTF-8";
    extraLocale = "pl_PL.UTF-8";

    git = {
      name = "kamack38";
      email = "64226248+kamack38@users.noreply.github.com";
      signingkey = "706A3FF0C395D52B";
    };

    theme = {
      colors = {
        c0 = "1e2127";
        c1 = "e06c75";
        c2 = "98c379";
        c3 = "d19a66";
        c4 = "61afef";
        c5 = "c678dd";
        c6 = "56b6c2";
        c7 = "abb2bf";
        c8 = "5c6370";
        c9 = "e06c75";
        c10 = "98c379";
        c11 = "d19a66";
        c12 = "61afef";
        c13 = "c678dd";
        c14 = "56b6c2";
        c15 = "ffffff";
      };
    };
  };
}
