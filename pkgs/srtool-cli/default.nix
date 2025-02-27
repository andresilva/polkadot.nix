{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "srtool-cli";
  version = "0.13.2";

  src = fetchFromGitHub {
    owner = "chevdor";
    repo = "srtool-cli";
    rev = "v${version}";
    hash = "sha256-uLQ+y2vP/Odv/ICqypHUvqnuHPiAfmJtWpG5kLgVWi8=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-O70wFsx7CWDtvRIRYvZybXpFP71L9C6TxUprnEQtASA=";

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
