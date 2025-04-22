{
  description = ''
    A collection of Nix packages related to the Polkadot ecosystem.
  '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    zombienet = {
      url = "github:paritytech/zombienet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      zombienet,
      ...
    }:
    let
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ zombienet.overlays.default ];
        };
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system (mkPkgs system));
    in
    {
      checks = eachSystem (
        system: pkgs: {
          buildAll = pkgs.symlinkJoin {
            name = "build-all-packages";
            paths = builtins.attrValues self.packages.${system};
          };
        }
      );
      devShells = eachSystem (
        system: pkgs: {
          default = import ./shell.nix { inherit pkgs; };
          local = with pkgs; mkShell { packages = [ nix-update ]; };
        }
      );
      packages = eachSystem (system: pkgs: import ./pkgs { inherit pkgs; });
    }
    // {
      overlays = {
        default =
          final: prev: import ./overlay.nix final (prev.appendOverlays [ zombienet.overlays.default ]);
      };
    };
}
