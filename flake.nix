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
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ fenix.overlays.default ];
          };
        in
        {
          packages = import ./pkgs { inherit pkgs; };
          devShells.default = import ./shell.nix { inherit pkgs; };
        }
      )
    // {
      overlays.default = final: prev:
        import ./overlay.nix final (prev.appendOverlays [ fenix.overlays.default ]);
    };
}
