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
      username = builtins.getEnv "USERNAME";
      gitName = builtins.getEnv "GIT_NAME";
      gitEmail = builtins.getEnv "GIT_EMAIL";
      profileNames = [
        "full"
        "minimal"
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      mkHome =
        system: profileName:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };
          modules = [ (./home/profiles + "/${profileName}.nix") ];
          extraSpecialArgs = { inherit username gitName gitEmail; };
        };
    in
    {
      homeConfigurations = builtins.listToAttrs (
        builtins.concatMap (
          system:
          map (profile: {
            name = "${username}-${profile}@${system}";
            value = mkHome system profile;
          }) profileNames
        ) systems
      );
    }
    // flake-utils.lib.eachSystem systems (system: {
      packages = builtins.listToAttrs (
        map (profile: {
          name = "${username}-${profile}";
          value = self.homeConfigurations."${username}-${profile}@${system}".activationPackage;
        }) profileNames
      );
      apps = {
        apply = {
          type = "app";
          program = "${self.homeConfigurations."${username}-full@${system}".activationPackage}/activate";
        };
      };
      defaultApp = self.apps.${system}.apply;
    });
}
