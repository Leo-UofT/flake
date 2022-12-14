{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:msteen/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, home-manager, vscode-server }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        wsl = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nixos = {
                imports = [ ./home.nix ];
              };
            }
            vscode-server.nixosModule
            ({ config, pkgs, ... }: {
              services.vscode-server.enable = true;
            })
          ];
        };
      };
    };
}
