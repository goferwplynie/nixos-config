{config, ...}: let
  githubUsername = "gofer";
  keyPath = "/home/gofer/.ssh/github";
in {
  sops.templates."git-credentials.conf".content = ''
    [user]
        email = ${config.sops.placeholder.git_email}
  '';

  programs.git = {
    enable = true;

    includes = [
      {path = config.sops.templates."git-credentials.conf".path;}
    ];

    settings = {
      user.name = "${githubUsername}";

      credential.helper = "!f() { echo \"password=$(cat ${config.sops.secrets.github_token.path})\"; }; f";

      gpg.format = "ssh";
      user.signingkey = "${keyPath}/id_ed25519.pub";
      commit.gpgsign = true;

      "url.git@github.com:".insteadOf = "https://github.com/";
    };
  };
}
