{
  callPackage,
  darwin,
  lib,
}:

callPackage ./generic.nix {
  inherit (darwin.apple_sdk.frameworks) Security SystemConfiguration;

  pname = "polkadot";
  target = "polkadot";
  description = "Implementation of a https://polkadot.network node in Rust based on the Substrate framework";
  license = lib.licenses.gpl3Only;
}
