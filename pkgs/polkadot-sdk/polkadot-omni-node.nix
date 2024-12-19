{
  callPackage,
  darwin,
  lib,
}:

callPackage ./generic.nix {
  inherit (darwin.apple_sdk.frameworks) Security SystemConfiguration;

  pname = "polkadot-omni-node";
  target = "cumulus/polkadot-omni-node";
  description = "Polkadot omni node that can be used to start a parachain node from a provided chain spec file";
  license = lib.licenses.gpl3Only;
}
