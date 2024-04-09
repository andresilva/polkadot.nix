{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-Ru9s2M20JNxBUMwaJKz43br65IGEgKTxfiBgs3B4/QE=";
  };

  cargoHash = "sha256-wXwBdchQdRcCXNOja4tEvRwgkNYQVNpjauI7rfQcJDw=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
