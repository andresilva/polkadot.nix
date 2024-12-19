{
  callPackage,
  darwin,
  lib,
}:

callPackage ./generic.nix {
  inherit (darwin.apple_sdk.frameworks) Security SystemConfiguration;

  pname = "frame-omni-bencher";
  target = "substrate/utils/frame/omni-bencher";
  description = "Polkadot Omni Benchmarking CLI";
  license = lib.licenses.asl20;
}
