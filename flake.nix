{
  description = "Personal Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      flake-utils,
      rust-overlay,
      self,
    }:
    let
      username = "dima";
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      mkHome =
        system: profile:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };
          modules = [ profile ];
          extraSpecialArgs = { inherit username; };
        };
      profiles = {
        "${username}" = ./home/profiles/full.nix;
        "${username}-minimal" = ./home/default.nix;
      };
    in
    {
      homeConfigurations = builtins.listToAttrs (
        builtins.concatMap (
          system:
          builtins.attrValues (
            builtins.mapAttrs (name: profile: {
              name = "${name}@${system}";
              value = mkHome system profile;
            }) profiles
          )
        ) systems
      );
    }
    // flake-utils.lib.eachSystem systems (
      system:
      {
        packages = builtins.mapAttrs (
          name: _: self.homeConfigurations."${name}@${system}".activationPackage
        ) profiles;
        apps = {
          apply = {
            type = "app";
            program = "${self.homeConfigurations."${username}@${system}".activationPackage}/activate";
          };
        };
        defaultApp = self.apps.${system}.apply;
      }
    );
}
