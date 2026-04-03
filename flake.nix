{
  description = "Personal Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, self }:
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
    };
}
