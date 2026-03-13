{pkgs, ...}: {
  imports = [
    ./nixvim
  ];
  home.packages = with pkgs; [
    lua-language-server
    nixd
    alejandra
    gopls
    gofumpt

    cargo

    jetbrains.idea
    opencode

    podman-compose
    gnumake

    usbutils
  ];
}
