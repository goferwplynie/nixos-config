{ pkgs, ... }: {
  home.packages = with pkgs; [
    rofi
    fastfetch
    hyprpaper
    cava
    playerctl
    swww
    wallust
  ];
}
