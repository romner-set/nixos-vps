{
  inputs = {
    #nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
    #nixpkgs-unstable,
    #microvm,
    #sops-nix,
    #home-manager,
  } @ attrs: {
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;

    nixosConfigurations = builtins.listToAttrs (map (name: {
      inherit name;
      value = nixpkgs.lib.nixosSystem rec {
        pkgs = import nixpkgs {
          inherit system;
          config = {};
        };
        system = "aarch64-linux";
        modules = [./common ./hosts/${name}];
      };
    }) (builtins.attrNames (builtins.readDir ./hosts)));
  };
}
