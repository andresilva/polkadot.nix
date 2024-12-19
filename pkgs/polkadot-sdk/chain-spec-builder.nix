{
  callPackage,
  darwin,
  lib,
}:

callPackage ./generic.nix {
  inherit (darwin.apple_sdk.frameworks) Security SystemConfiguration;

  pname = "chain-spec-builder";
  target = "substrate/bin/utils/chain-spec-builder";
  description = "Substrate's chain spec builder utility";
  license = lib.licenses.asl20;
}
