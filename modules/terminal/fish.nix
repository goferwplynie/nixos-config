{ ... }:
let
  flakePath = "~/.config/home-manager";
  fastfetchPath = "~/.config/home-manager/dotfiles/fastfetch";
in
{
  programs.fish = {
    enable = true;

    shellInit = ''
      set -Ua fish_user_paths $HOME/.local/bin
    '';

    shellAliases = {
      hms = "home-manager switch --flake ${flakePath}";
      nsw = "sudo nixos-rebuild switch --flake ${flakePath}#$(hostname)";
      all-switch = "nsw && hms";
    
      update = "pushd ${flakePath} && nix flake update && nsw && hms && popd";
      clean = "nix-env --delete-generations old && nix-collect-garbage -d && sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && sudo nix-collect-garbage -d";
    };
    
    interactiveShellInit = ''
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -g fish_greeting - ""
      kitten icat -n --align left --scale-up --place 30x30@2x2 ${fastfetchPath}/felix1.gif | fastfetch --logo-width 30 --raw -
    '';
  };
}
