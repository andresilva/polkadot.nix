{
  pkgs,
  fenixPkgs,
  channel ? "stable",
  linker ? "wild",
  packages ? [ ],
  env ? { },
  shellHook ? "",
}:

assert pkgs.lib.assertOneOf "channel" channel [
  "stable"
  "beta"
  "latest"
];
assert pkgs.lib.assertOneOf "linker" linker [
  "mold"
  "wild"
  "lld"
];

let
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
  cargoLinker =
    with pkgs;
    let
      rustTarget = stdenv.hostPlatform.rust.cargoEnvVarTarget;
      mkLinkerFlags = ld: "-Clink-arg=-fuse-ld=${ld} -Clink-arg=-Wl,--no-rosegment -Clink-arg=-flto";
      linkerFlags = {
        lld = mkLinkerFlags "${llvmPackages_latest.lld}/bin/ld.lld";
        mold = mkLinkerFlags "${mold}/bin/ld.mold";
        wild = mkLinkerFlags "${wild}/bin/ld.wild";
      };
      rustflags =
        if stdenv.hostPlatform.isDarwin then
          "-Clink-arg=-fuse-ld=${llvmPackages_latest.lld}/bin/ld64.lld"
        else
          linkerFlags.${linker};
    in
    {
      "CARGO_TARGET_${rustTarget}_LINKER" = "clang";
      "CARGO_TARGET_${rustTarget}_RUSTFLAGS" = rustflags;
    };
in
with pkgs;
mkShell.override { stdenv = llvmPackages_latest.stdenv; } {
  inherit shellHook;

  packages =
    packages
    ++ [
      llvmPackages_latest.lld
      openssl
      pkg-config
      rust-toolchain
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      rust-jemalloc-sys-unprefixed
    ];

  env = {
    LIBCLANG_PATH = lib.makeLibraryPath [ llvmPackages_latest.libclang ];
    RUST_SRC_PATH = "${rust-toolchain}/lib/rustlib/src/rust/library";

    OPENSSL_NO_VENDOR = 1;
    PROTOC = "${lib.makeBinPath [ protobuf ]}/protoc";
    ROCKSDB_LIB_DIR = lib.makeLibraryPath [ rocksdb ];
  }
  // cargoLinker
  // env;
}
