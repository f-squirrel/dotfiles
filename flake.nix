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
    { nixpkgs, home-manager, ... }:
    let
      username = "dima";
      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home/default.nix ];
          extraSpecialArgs = { inherit username; };
        };
    in
    {
      homeConfigurations = {
        "${username}@x86_64-linux" = mkHome "x86_64-linux";
        "${username}@aarch64-linux" = mkHome "aarch64-linux";
        "${username}@x86_64-darwin" = mkHome "x86_64-darwin";
        "${username}@aarch64-darwin" = mkHome "aarch64-darwin";
      };
    };
}
