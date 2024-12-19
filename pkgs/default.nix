{ pkgs }:

{
  graypaper = pkgs.callPackage ./graypaper { };

  polkadot = pkgs.callPackage ./polkadot/polkadot.nix { };
  srtool-cli = pkgs.callPackage ./srtool-cli { };
  subalfred = pkgs.callPackage ./subalfred { };
  subkey = pkgs.callPackage ./subkey { };
  subrpc = pkgs.callPackage ./subrpc { };
  subwasm = pkgs.callPackage ./subwasm { };
  subxt-cli = pkgs.callPackage ./subxt-cli { };
  zepter = pkgs.callPackage ./zepter { };
  zombienet = pkgs.zombienet.default;
}
