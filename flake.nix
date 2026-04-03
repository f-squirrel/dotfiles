{
  description = "Personal Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, home-manager, flake-utils, self }:
    let
      username = "dima";
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
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
    // flake-utils.lib.eachSystem systems (system:
      let
        hmConfig = self.homeConfigurations."${username}@${system}";
      in
      {
        apps = {
          apply = {
            type = "app";
            program = "${hmConfig.activationPackage}/activate";
          };
          build = {
            type = "app";
            program = toString (
              nixpkgs.legacyPackages.${system}.writeShellScript "build-home" ''
                echo "${hmConfig.activationPackage}"
              ''
            );
          };
        };
        defaultApp = self.apps.${system}.apply;
      }
    );
}
