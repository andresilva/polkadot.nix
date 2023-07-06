{ pkgs }:

{
  polkadot = pkgs.callPackage ./polkadot {
    inherit (pkgs.darwin.apple_sdk.frameworks) Security SystemConfiguration;
  };
  srtool-cli = pkgs.callPackage ./srtool-cli { };
  subkey = pkgs.callPackage ./subkey { };
  subwasm = pkgs.callPackage ./subwasm { };
  subxt-cli = pkgs.callPackage ./subxt-cli { };
}
