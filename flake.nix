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
          hello = pkgs.hello;
          default = pkgs.hello;
        };

        devShells.default = import ./shell.nix { inherit pkgs; };
      }
    );
}
