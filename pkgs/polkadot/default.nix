{ lib
, fetchFromGitHub
, fenix
, makeRustPlatform
, protobuf
, rocksdb
, stdenv
, Security
, SystemConfiguration
}:

let
  rust-toolchain = with fenix; combine [
    (stable.withComponents [
      "cargo"
      "rustc"
    ])
    targets.wasm32-unknown-unknown.stable.rust-std
  ];

  rustPlatform = makeRustPlatform {
    cargo = rust-toolchain;
    rustc = rust-toolchain;
  };
in
rustPlatform.buildRustPackage rec {
  pname = "polkadot";
  version = "0.9.43";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "polkadot";
    rev = "v${version}";
    hash = "sha256-h+9b+KQgdYowHYGr0nPsqibcwOPmBVo9tKi/uEbLhqo=";

    # the build process of polkadot requires a .git folder in order to determine
    # the git commit hash that is being built and add it to the version string.
    # since having a .git folder introduces reproducibility issues to the nix
    # build, we check the git commit hash after fetching the source and save it
    # into a .git_commit file, and then delete the .git folder. we can then use
    # this file to populate an environment variable with the commit hash, which
    # is picked up by polkadot's build process.
    leaveDotGit = true;
    postFetch = ''
      ( cd $out; git rev-parse --short HEAD > .git_commit )
      rm -rf $out/.git
    '';
  };

  preBuild = ''
    export SUBSTRATE_CLI_GIT_COMMIT_HASH=$(cat .git_commit)
    rm .git_commit
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "binary-merkle-tree-4.0.0-dev" = "sha256-/8bGqnM/yqtCgVWkIaVEySZSV3XGYuiA3JuyHYTp2lw=";
      "sub-tokens-0.1.0" = "sha256-GvhgZhOIX39zF+TbQWtTCgahDec4lQjH+NqamLFLUxM=";
    };
  };

  buildInputs = lib.optionals stdenv.isDarwin [ Security SystemConfiguration ];

  nativeBuildInputs = [ rustPlatform.bindgenHook ];

  PROTOC = "${protobuf}/bin/protoc";
  ROCKSDB_LIB_DIR = "${rocksdb}/lib";

  meta = with lib; {
    description = "Polkadot Node Implementation";
    homepage = "https://github.com/paritytech/polkadot";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
