{
  pkgs ? import <nixpkgs> { },
}:

let
  mold = pkgs.wrapBintoolsWith { bintools = pkgs.mold; };
  rustfmt-nightly = pkgs.rustfmt.override { asNightly = true; };
in
with pkgs;
mkShell.override { stdenv = clangStdenv; } {
  packages =
    [
      cargo
      clippy
      openssl
      pkg-config
      rust-analyzer
      rustc
      rustc.llvmPackages.lld
      rustfmt-nightly
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      rust-jemalloc-sys-unprefixed
    ];

  # use mold as linker on linux x86_64
  CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER = "clang";
  CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUSTFLAGS = "-C link-arg=-fuse-ld=${mold}/bin/ld.mold";

  LIBCLANG_PATH = lib.makeLibraryPath [ llvmPackages.libclang ];
  RUST_SRC_PATH = "${rustPlatform.rustLibSrc}";

  OPENSSL_NO_VENDOR = 1;
  PROTOC = "${lib.makeBinPath [ protobuf ]}/protoc";
  ROCKSDB_LIB_DIR = lib.makeLibraryPath [ rocksdb ];
}
