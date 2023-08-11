{
  description = "A simple Fortran program using HDF5";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  # inputs.nix-extra.url = "github:nialov/nix-extra/feat-package-dfnworks";

  outputs = { self, ... }@inputs:

    let

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";

        overlays = [
          (_: prev:
            {

              # inherit (inputs.nix-extra.packages."x86_64-linux") hdf5-full;

            })

        ];

      };

    in {

      packages.x86_64-linux.default = pkgs.callPackage ./default.nix { };

    };
}
