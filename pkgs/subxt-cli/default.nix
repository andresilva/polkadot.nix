{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.29.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-fMCy1QAb8rdgQesRqbNCEh6lqEgf7ZsVhYdGvctjbQU=";
  };

  cargoHash = "sha256-QImpaQURB0ji4DwnD2TovrYqnsYyVv1P7Cz39eUOz5o=";

  buildAndTestSubdir = "cli";

  meta = with lib; {
    description = "Utilities for working with substrate metadata for subxt";
    homepage = "https://github.com/paritytech/subxt";
    mainProgram = "subxt";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
