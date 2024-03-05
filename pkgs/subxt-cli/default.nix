{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.34.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-1SkAYJ6YdZeaD3c1pekd/nwTEI9Zt/2fmA3Y7PPLxoE=";
  };

  cargoHash = "sha256-vfij4izUhrAt4sJPpse9xv4s4cD0WT0/SQeGEQnubJM=";

  buildAndTestSubdir = "cli";

  doCheck = false;

  meta = with lib; {
    description = "Utilities for working with substrate metadata for subxt";
    homepage = "https://github.com/paritytech/subxt";
    mainProgram = "subxt";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
