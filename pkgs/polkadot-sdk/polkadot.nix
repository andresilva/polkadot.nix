{
  callPackage,
  lib,
  rust-jemalloc-sys-unprefixed,
}:

(callPackage ./generic.nix {
  pname = "polkadot";
  target = "polkadot";
  description = "Implementation of a https://polkadot.network node in Rust based on the Substrate framework";
  license = lib.licenses.gpl3Only;
  rust-jemalloc-sys = rust-jemalloc-sys-unprefixed;
}).overrideAttrs
  (_: {
    doCheck = false;
    cargoBuildFlags = [ "--features=jemalloc-allocator" ];
  })
