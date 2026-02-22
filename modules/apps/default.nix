{ pkgs, ... }:
{
  imports = [
    ./vesktop.nix
    ./flameshot.nix
    ./obs.nix
    ./browser.nix
  ];

  home.packages = with pkgs;[
    spotify
  ];
}
