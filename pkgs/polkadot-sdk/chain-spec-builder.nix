{
  callPackage,
  lib,
}:

callPackage ./generic.nix {
  pname = "chain-spec-builder";
  target = "substrate/bin/utils/chain-spec-builder";
  description = "Substrate's chain spec builder utility";
  license = lib.licenses.asl20;
}
