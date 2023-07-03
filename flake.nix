{
  description = ''
    A collection of Nix packages related to the Polkadot ecosystem.
  '';

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs-unstable, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs-unstable.legacyPackages.${system};
      in
      {
        packages = {
          srtool-cli = pkgs.callPackage ./pkgs/srtool-cli { };
          subkey = pkgs.callPackage ./pkgs/subkey { };
          subwasm = pkgs.callPackage ./pkgs/subwasm { };
          subxt-cli = pkgs.callPackage ./pkgs/subxt-cli { };
        };

        devShells.default = import ./shell.nix { inherit pkgs; };
      }
    );
}
