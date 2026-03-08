{config, ...}: let
  githubUsername = "gofer";
in {
  sops.templates."git-credentials.conf".content = ''
    [user]
        email = ${config.sops.placeholder.git_email}
  '';
  programs.git = {
    enable = true;

    # 2. Mówimy Gitowi, żeby "wessał" ten wygenerowany przez SOPSa plik
    includes = [
      {path = config.sops.templates."git-credentials.conf".path;}
    ];

    settings = {
      # Tutaj ląduje Twoja nazwa użytkownika (zamiast starego userName)
      user.name = "${githubUsername}";

      # Twój genialny trik z helperem
      credential.helper = "!f() { echo \"password=$(cat ${config.sops.secrets.github_token.path})\"; }; f";
    };
  };
}
