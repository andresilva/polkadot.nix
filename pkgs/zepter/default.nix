{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zepter";
  version = "1.78.0";

  src = fetchFromGitHub {
    owner = "ggwpez";
    repo = "zepter";
    rev = "v${version}";
    hash = "sha256-WNmtyiLk4FZu69EdFiiDvYdvnBTok7fvM3BJ45VqxCc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-DW2msGXu/2CcM02GY+6tfQEkOjmwoTg8TG/yrMD7drM=";

  meta = with lib; {
    description = "Analyze, Fix and Format features in your Rust workspace";
    homepage = "https://github.com/ggwpez/zepter";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
