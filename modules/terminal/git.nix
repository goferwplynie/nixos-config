{pkgs, ...}: let
  githubUsername = "gofer";
  keyPath = "/home/gofer/.ssh/github";
in {
  programs.git = {
    enable = true;
    includes = [
      {path = "~/.config/git/secrets.inc";}
    ];

    settings = {
      user.name = "${githubUsername}";

      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";

      gpg.format = "ssh";
      user.signingkey = "${keyPath}/id_ed25519.pub";
      commit.gpgsign = true;
    };
  };
}
