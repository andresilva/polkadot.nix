{
  description = ''
    A collection of Nix packages related to the Polkadot ecosystem.
  '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, fenix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ fenix.overlays.default ];
        };
      in
      {
        packages = {
          polkadot = pkgs.callPackage ./pkgs/polkadot {
            inherit (pkgs.darwin.apple_sdk.frameworks) Security SystemConfiguration;
          };
          srtool-cli = pkgs.callPackage ./pkgs/srtool-cli { };
          subkey = pkgs.callPackage ./pkgs/subkey { };
          subwasm = pkgs.callPackage ./pkgs/subwasm { };
          subxt-cli = pkgs.callPackage ./pkgs/subxt-cli { };
        };

        devShells.default = import ./shell.nix { inherit pkgs; };
      }
    );
}
