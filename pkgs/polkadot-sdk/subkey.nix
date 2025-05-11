{
  callPackage,
  lib,
}:

callPackage ./generic.nix {
  pname = "subkey";
  target = "substrate/bin/utils/subkey";
  description = "Utility for generating and using Substrate keys";
  license = lib.licenses.asl20;
}
