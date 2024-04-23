{
  description = "Nix Flakes";

  nixConfig = {
    # nix community's cache server
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur,
      ...
    }@inputs:
    let
      user = {
        name = "hjw";
        fullname = "Jianwei Han";
        github = "hanjianwei";
        email = "hanjianwei@gmail.com";
      };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      allowUnfree = {
        nixpkgs.config.allowUnfree = true;
      };
      mkSystem =
        {
          host,
          dpi ? 96,
        }:
        nixpkgs.lib.nixosSystem {
          system = system;

          modules = [
            nur.hmModules.nur
            ./hosts/${host}
            {
              _module.args = {
                inherit user;
              };
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user.name} = import ./home;
              home-manager.sharedModules = [ nur.hmModules.nur ];
              home-manager.extraSpecialArgs = {
                inherit dpi;
                inherit user;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        moa = mkSystem { host = "moa"; };
        mako = mkSystem {
          host = "mako";
          dpi = 192;
        };
      };

      homeConfigurations."${user.name}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          allowUnfree
          ./home/standalone.nix
          {
            _module.args = {
              inherit user;
              dpi = 192;
            };
          }
        ];
      };

      formatter.${system} = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
