{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { cavaSupport = true; };
  };
}
