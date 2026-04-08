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

  users.users.${username}.home = "/Users/${username}";

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 5;
}
