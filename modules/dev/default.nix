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

    go

    cargo
    nodejs_latest

    jetbrains.idea
    android-studio-full
    opencode

    podman-compose
    gnumake

    usbutils

    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    ripgrep
  ];
}
