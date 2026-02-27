{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.88.0";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-IGwTid/btNWamY6SDd7qAG7NCIo7Ol7CBBh+39GK1Cg=";
  };

  cargoHash = "sha256-YP+OgjCtWz+oOatlV4i8LbQY2AL//MEw2CGay/qAv3M=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
