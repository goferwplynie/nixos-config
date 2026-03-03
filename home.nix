{ config, pkgs, inputs, ... }:

let
  homePath = "/home/gofer";
  dotfilesPath = "${homePath}/.config/home-manager/dotfiles";
  userId = "1000";
  scriptsDir = ./dotfiles/scripts;
  allScripts = builtins.attrNames (builtins.readDir scriptsDir);
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./modules/terminal 
    ./modules/apps
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

  home.packages = with pkgs;[
  	rofi
  	fastfetch
	kdePackages.dolphin
	hyprpaper
	jetbrains-mono
	easyeffects
	lua-language-server
	nixd
	alejandra
	usbutils
	cava
	playerctl
	swww
	wallust
  ];

  home.file = {
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/waybar";
    ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fastfetch";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/nvim";
    ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/kitty";
    ".config/.wallpapers".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.wallpapers";
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/hypr";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/rofi";
    ".config/wallust".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/wallust";
    ".config/cava".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/wallust";
  } // #loop >:3
  builtins.listToAttrs (map (name: {
      name = ".local/bin/${name}";
      value = {
        source = scriptsDir + "/${name}";
        executable = true;
      };
    }) allScripts);

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_AUTHOR_EMAIL = "$(cat ${config.sops.secrets.git_email.path})";
    GIT_COMMITTER_EMAIL = "$(cat ${config.sops.secrets.git_email.path})";
    XDG_DATA_DIRS = "${homePath}/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.waybar = {
    enable = true;

    package = pkgs.waybar.override{ cavaSupport = true; };
  };

}
