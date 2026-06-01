{pkgs, ...}: {
  imports = [
    ./vesktop.nix
    ./flameshot.nix
    ./obs.nix
    ./browser.nix
    ./ncspot.nix
  ];

  home.packages = with pkgs; [
    ventoy
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
    prismlauncher
    r2modman
    google-chrome
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
}
