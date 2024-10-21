{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "srtool-cli";
  version = "0.12.0";

  src = fetchFromGitHub {
    owner = "chevdor";
    repo = "srtool-cli";
    rev = "v${version}";
    hash = "sha256-CAmw8Eri1KUznU6lTb11j5tp5cAWBk6NB5j0zVZWOqU=";
  };

  cargoHash = "sha256-zLWhPQI8dXmpIgC/ZwaAU436h+JLSi51g55q7LG9Q/c=";

  doCheck = false;

  meta = with lib; {
    description = "CLI utility that helps you harness the srtool docker image without breaking a sweat";
    homepage = "https://github.com/chevdor/srtool-cli";
    mainProgram = "srtool";
    license = licenses.mit;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
