{
  callPackage,
  lib,
}:

callPackage ./generic.nix {
  pname = "polkadot-omni-node";
  target = "cumulus/polkadot-omni-node";
  description = "Polkadot omni node that can be used to start a parachain node from a provided chain spec file";
  license = lib.licenses.gpl3Only;
}
