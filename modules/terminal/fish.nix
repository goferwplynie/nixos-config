{ ... }:
let
  flakePath = "~/.config/home-manager";
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      hms = "home-manager switch --flake ${flakePath}";
      nsw = "sudo nixos-rebuild switch --flake ${flakePath}#$(hostname)";
      all-switch = "nsw && hms";
    
      update = "pushd ${flakePath} && nix flake update && nsw && hms && popd";
      clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
    
    interactiveShellInit = ''
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -g fish_greeting - ""
      kitten icat -n --align left --scale-up --place 30x30@2x2 ~/fastfetchAssets/felix1.gif | fastfetch --logo-width 30 --raw -
    '';
  };
}
