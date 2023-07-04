{ pkgs }:

let
  rust-toolchain = with pkgs.fenix; combine [
    (stable.withComponents [
      "cargo"
      "clippy"
      "rust-analyzer"
      "rust-src"
      "rustc"
    ])
    (latest.withComponents [ "rustfmt" ])
    targets.wasm32-unknown-unknown.stable.rust-std
  ];
  mold = pkgs.wrapBintoolsWith { bintools = pkgs.mold; };
in
with pkgs; mkShell {
  buildInputs = [
    clang
    openssl
    pkg-config
    rust-toolchain
  ];

  # use mold as linker on linux x86_64
  CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER = "clang";
  CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUSTFLAGS = "-C link-arg=-fuse-ld=${mold}/bin/ld.mold";

  LIBCLANG_PATH = lib.makeLibraryPath [ llvmPackages.libclang ];
  PROTOC = "${lib.makeBinPath [ protobuf ]}/protoc";
  ROCKSDB_LIB_DIR = lib.makeLibraryPath [ rocksdb ];
  RUST_SRC_PATH = "${rust-toolchain}/lib/rustlib/src/rust/library";
}
