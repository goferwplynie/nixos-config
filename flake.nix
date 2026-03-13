{
  description = "Extremely cute flake for boykisser and cutie";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    mkPkgs = pkgs:
      import pkgs {
        inherit system;
        config.allowUnfree = true;
      };
    pkgs = mkPkgs nixpkgs;
  in {
    nixosConfigurations = {
      boykisser = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/boykisser/configuration.nix
        ];
      };
      cutie = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/cutie/configuration.nix
        ];
      };
    };

    homeConfigurations."gofer" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./home.nix
      ];
    };
  };
}
