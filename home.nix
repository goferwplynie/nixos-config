{ config, pkgs, inputs, ... }:

let
  homePath = "/home/gofer";
  dotfilesPath = "${homePath}/.config/home-manager/dotfiles";
  flakePath = "${homePath}/.config/home-manager";
  githubUsername = "gofer";
  userId = "1000";
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.spicetify-nix.homeManagerModules.default
  ];
  sops = {
  	defaultSopsFile = ./secrets.yaml;
	age.sshKeyPaths = [ "${homePath}/.ssh/id_ed25519" ]; 
	defaultSymlinkPath = "${homePath}/.secrets";
  	defaultSecretsMountPoint = "/run/user/${userId}/secrets.d";
	secrets = {
		git_email = {};
		github_token = {};
	};
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gofer";
  home.homeDirectory = homePath;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
  	rofi
	waybar
  	fastfetch
	lua-language-server
	kdePackages.dolphin
	hyprpaper
	jetbrains-mono
  ];
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/waybar";
    ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fastfetch";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/nvim";
    ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/kitty";
    # ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink dotfiles/hypr;

   # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gofer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_AUTHOR_EMAIL = "$(cat ${config.sops.secrets.git_email.path})";
    GIT_COMMITTER_EMAIL = "$(cat ${config.sops.secrets.git_email.path})";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.spicetify = {
  	enable = true;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];

  };
  programs.fish = {
    enable = true;

    shellAliases = {
      hms = "home-manager switch --flake ${flakePath}";
      nsw = "sudo nixos-rebuild switch --flake ${flakePath}#$(hostname)";
      all-switch = "nsw && hms";
    
      update = "pushd ${flakePath} && nix flake update && nsw && hms && popd";
      clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
    
    interactiveShellInit = ''
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -g fish_greeting - ""
      kitten icat -n --align left --scale-up --place 30x30@2x2 ~/fastfetchAssets/felix1.gif | fastfetch --logo-width 30 --raw -
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$all";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "${githubUsername}";		
      credential.helper = "!f() { echo \"password=$(cat ${config.sops.secrets.github_token.path})\"; }; f";
    };
  };
  programs.vesktop = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };
}
