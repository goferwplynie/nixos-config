{ pkgs, ... }:
{
  imports = [
    ./vesktop.nix
    ./flameshot.nix
    ./obs.nix
    ./browser.nix
    ./ncspot.nix
  ];

  home.packages = with pkgs;[
    spotify
  ];
}
