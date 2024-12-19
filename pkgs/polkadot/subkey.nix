{
  callPackage,
  darwin,
  lib,
}:

callPackage ./generic.nix {
  inherit (darwin.apple_sdk.frameworks) Security SystemConfiguration;

  pname = "subkey";
  target = "substrate/bin/utils/subkey";
  description = "Utility for generating and using Substrate keys";
  license = lib.licenses.asl20;
}
