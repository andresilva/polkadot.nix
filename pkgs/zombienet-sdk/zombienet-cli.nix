{ callPackage }:

callPackage ./generic.nix {
  pname = "zombienet-cli";
  description = "Zombienet cli, entrypoint for using zombienet";
  target = "crates/cli";
}
