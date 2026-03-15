{...}: let
  keyPath = "/home/gofer/.ssh/github";
in {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "${keyPath}/id_ed25519";
      };
    };
  };
}
