{
  callPackage,
  lib,
}:

callPackage ./generic.nix {
  pname = "frame-omni-bencher";
  target = "substrate/utils/frame/omni-bencher";
  description = "Polkadot Omni Benchmarking CLI";
  license = lib.licenses.asl20;
}
