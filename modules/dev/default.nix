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
    golangci-lint

    go
    python3

    cargo
    nodejs_latest
    pnpm

    air
    templ
    just
    mise
    cobra-cli

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
    websocat
  ];
}
