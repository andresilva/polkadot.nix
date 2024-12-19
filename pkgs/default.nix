{ pkgs }:

{
  graypaper = pkgs.callPackage ./graypaper { };

  polkadot = pkgs.callPackage ./polkadot-sdk/polkadot.nix { };
  polkadot-omni-node = pkgs.callPackage ./polkadot-sdk/polkadot-omni-node.nix { };
  polkadot-parachain = pkgs.callPackage ./polkadot-sdk/polkadot-parachain.nix { };
  chain-spec-builder = pkgs.callPackage ./polkadot-sdk/chain-spec-builder.nix { };
  frame-omni-bencher = pkgs.callPackage ./polkadot-sdk/frame-omni-bencher.nix { };
  subkey = pkgs.callPackage ./polkadot-sdk/subkey.nix { };

  srtool-cli = pkgs.callPackage ./srtool-cli { };
  subalfred = pkgs.callPackage ./subalfred { };
  subrpc = pkgs.callPackage ./subrpc { };
  subwasm = pkgs.callPackage ./subwasm { };
  subxt-cli = pkgs.callPackage ./subxt-cli { };
  zepter = pkgs.callPackage ./zepter { };
  zombienet = pkgs.zombienet.default;
}
