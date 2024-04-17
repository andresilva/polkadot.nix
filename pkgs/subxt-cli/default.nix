{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.35.3";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-5G5gFxr7CIvZ1RfkLIEF/z4t+wTj09fJXTNr2v0vuyg=";
  };

  cargoHash = "sha256-7tFKVaBi3d1x6TzD0ov/DhMLtrn+fMS+yCtFWck+KeM=";

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
