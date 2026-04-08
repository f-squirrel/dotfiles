{
  username,
  gitName,
  gitEmail,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username gitName gitEmail; };
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
