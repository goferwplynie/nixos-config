{ pkgs, ... }:
{
  home.packages = with pkgs;[
    grim
  ];

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        useGrimAdapter = true;
	disabledGrimWarning = true;
      };
    };
  };
}
