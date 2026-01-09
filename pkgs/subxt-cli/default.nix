{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.44.1";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-W4bQVgEvnmYZomLD4ToProCvAKnh94Mw9Rr18b9GVEg=";
  };

  cargoHash = "sha256-AdFO0U3vj7yxhGmpXkn6iIQ8+zS6dd+eGVkWnonoy24=";

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
