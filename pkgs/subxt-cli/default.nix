{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.41.0";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-zg2MraqKLbyhaxTi02rE4MsMuPw4diIseYNUQEoqnVA=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-leJp+Ccb2mij46Cx6+pv7GoHLKG5IVlNeih0L2QQp4w=";

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
