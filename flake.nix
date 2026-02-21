{
  description = "Extremely cute flake for boykisser and cutie";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      mkPkgs = pkgs: import pkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = mkPkgs nixpkgs;
    in {
      nixosConfigurations = {
        boykisser = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/boykisser/configuration.nix
          ];
        };
      };

      homeConfigurations."gofer" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix
        ];
      };
    };
}
