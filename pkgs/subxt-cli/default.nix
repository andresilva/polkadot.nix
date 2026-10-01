{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subxt-cli";
  version = "0.51.1";

  src = fetchFromGitHub {
    owner = "paritytech";
    repo = "subxt";
    rev = "v${version}";
    hash = "sha256-/bM/GhLVpaWemrm1gCDzsvg0jU4cKvH57PFXwLHbddg=";
  };

  cargoHash = "sha256-2CuEDDdnrs4zN/uvhRhbUvuVHgBJqIhl12hLBUXixgg=";

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
