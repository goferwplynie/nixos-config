{pkgs, ...}: {
  imports = [
    ./vesktop.nix
    ./flameshot.nix
    ./obs.nix
    ./browser.nix
    ./ncspot.nix
  ];

  home.packages = with pkgs; [
    spotify
    kdePackages.dolphin
    kdePackages.kio-extras
    kdePackages.kio-admin
    easyeffects
    postman
    htop
    yazi
    mako
    ouch
    obsidian
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
}
