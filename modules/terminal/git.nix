{config, ...}: let
  githubUsername = "gofer";
in {
  sops.templates."git-credentials.conf".content = ''
    [user]
        email = ${config.sops.placeholder.git_email}
  '';

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "/home/${githubUsername}/.ssh/github/id_ed25519";
      };
    };
  };

  programs.git = {
    enable = true;

    includes = [
      {path = config.sops.templates."git-credentials.conf".path;}
    ];

    settings = {
      user.name = "${githubUsername}";

      credential.helper = "!f() { echo \"password=$(cat ${config.sops.secrets.github_token.path})\"; }; f";

      gpg.format = "ssh";
      user.signingkey = "/home/${githubUsername}/.ssh/github/id_ed25519.pub";
      commit.gpgsign = true;

      "url.git@github.com:".insteadOf = "https://github.com/";
    };
  };
}
