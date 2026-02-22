{ config, ... }:
let
  githubUsername = "gofer";
in
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "${githubUsername}";		
      credential.helper = "!f() { echo \"password=$(cat ${config.sops.secrets.github_token.path})\"; }; f";
    };
  };
}
