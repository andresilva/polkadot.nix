{
  callPackage,
  darwin,
  lib,
}:

callPackage ./generic.nix {
  inherit (darwin.apple_sdk.frameworks) Security SystemConfiguration;

  pname = "polkadot-parachain";
  target = "cumulus/polkadot-parachain";
  description = "Polkadot omni node for system parachains";
  license = lib.licenses.gpl3Only;
}
