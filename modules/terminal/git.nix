{pkgs, ...}: let
in {
  programs.git = {
    enable = true;

    # Tutaj dzieje się magia dla pracy!
    settings = {
      gpg.format = "ssh";
      commit.gpgsign = true;

      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";

      "includeIf \"gitdir:~/work/\"" = {
        path = "~/.config/git/work.inc";
      };
      "includeIf \"gitdir:~/programming/\"" = {
        path = "~/.config/git/secrets.inc";
      };
      "includeIf \"gitdir:~/.config/\"" = {
        path = "~/.config/git/secrets.inc";
      };
    };
  };
}
