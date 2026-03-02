{
  pkgs ? import <nixpkgs> { },
  fenixPkgs,
  channel ? "stable",
}:

let
  mold = pkgs.wrapBintoolsWith { bintools = pkgs.mold; };
  channelPkgs = fenixPkgs.${channel};
  rust-toolchain = fenixPkgs.combine [
    (channelPkgs.withComponents [
      "cargo"
      "clippy"
      "llvm-tools"
      "rust-analyzer"
      "rust-src"
      "rustc"
    ])
    fenixPkgs.latest.rustfmt
    fenixPkgs.targets.wasm32-unknown-unknown.${channel}.rust-std
  ];
in
with pkgs;
mkShell.override { stdenv = clangStdenv; } {
  packages = [
    llvmPackages.lld
    openssl
    pkg-config
    rust-toolchain
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    rust-jemalloc-sys-unprefixed
  ];

  # use mold as linker on linux x86_64
  CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER = "clang";
  CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUSTFLAGS = "-C link-arg=-fuse-ld=${mold}/bin/ld.mold";

  LIBCLANG_PATH = lib.makeLibraryPath [ llvmPackages.libclang ];
  RUST_SRC_PATH = "${rust-toolchain}/lib/rustlib/src/rust/library";

  OPENSSL_NO_VENDOR = 1;
  PROTOC = "${lib.makeBinPath [ protobuf ]}/protoc";
  ROCKSDB_LIB_DIR = lib.makeLibraryPath [ rocksdb ];
}
