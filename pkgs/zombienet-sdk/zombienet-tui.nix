{ callPackage }:

callPackage ./generic.nix {
  pname = "zombienet-tui";
  description = "Terminal UI for monitoring and managing zombienet networks";
  target = "crates/tui";
}
