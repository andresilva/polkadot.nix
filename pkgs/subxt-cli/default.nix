{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.43.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-BV/zP0L0gDmLSuzkp4OkOPfgldXBUiaHL4rciM7lrno=";
  };

  cargoHash = "sha256-7kmxnlhgNj0hY9FwVrzmdHw73Jf/pSeTHi6sqDg9X24=";

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
