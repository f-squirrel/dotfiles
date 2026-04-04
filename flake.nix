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
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };
          modules = [ ./home/default.nix ];
          extraSpecialArgs = { inherit username; };
        };
    in
    {
      homeConfigurations = builtins.listToAttrs (
        map (system: {
          name = "${username}@${system}";
          value = mkHome system;
        }) systems
      );
    }
    // flake-utils.lib.eachSystem systems (
      system:
      let
        hmConfig = self.homeConfigurations."${username}@${system}";
      in
      {
        packages = {
          activation = hmConfig.activationPackage;
        };
        apps = {
          apply = {
            type = "app";
            program = "${hmConfig.activationPackage}/activate";
          };
        };
        defaultApp = self.apps.${system}.apply;
      }
    );
}
