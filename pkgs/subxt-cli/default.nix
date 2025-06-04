{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.40.1";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-zEfEq6KnU0lVAPGGF8CsZHk9kVvPiauxzpxdR1TEdsw=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-tZaKsRJ6cuj7HI1M/aODHF1VR+HZu9AKW2YzwYludCM=";

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
