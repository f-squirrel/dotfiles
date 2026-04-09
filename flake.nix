{
  description = "Personal Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
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
      nix-darwin,
      flake-utils,
      rust-overlay,
      self,
    }:
    let
      username = builtins.getEnv "USERNAME";
      gitName = builtins.getEnv "GIT_NAME";
      gitEmail = builtins.getEnv "GIT_EMAIL";
      profileNames = [
        "dev"
        "full"
        "minimal"
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      darwinSystems = [
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
          modules = [ (./profiles/linux + "/${profileName}.nix") ];
          extraSpecialArgs = { inherit username gitName gitEmail; };
        };
      mkDarwin =
        system: profileName:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            home-manager.darwinModules.home-manager
            (./profiles/darwin + "/${profileName}.nix")
            {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              nixpkgs.hostPlatform = system;
            }
          ];
          specialArgs = { inherit username gitName gitEmail; };
        };
    in
    {
      darwinConfigurations = builtins.listToAttrs (
        builtins.concatMap (
          system:
          map (profile: {
            name = "${username}-${profile}@${system}";
            value = mkDarwin system profile;
          }) profileNames
        ) darwinSystems
      );

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
    });
}
