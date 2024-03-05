{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-PeDmAG1xMnfagvSsmOzmIRc0xBZx7hUVvfEytfuBcEs=";
  };

  cargoHash = "sha256-j7pIUvxuMrLcYzYhqflCu8yaFfFveouRbtTxg/hhe6s=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
