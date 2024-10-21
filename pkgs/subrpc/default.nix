{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subrpc";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "chevdor";
    repo = "subrpc";
    rev = "v${version}";
    hash = "sha256-7FuOJpYMTwTSonJ4COw5BRN8h3tMJEH3z2B57tpmmHE=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "jsonrpsee-0.21.0" = "sha256-v6gaDFYdJtm5Do8Q44Cen5frjWSIYF788XEQS4XC8GE=";
    };
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false;

  meta = with lib; {
    description = "SubRPC helps maintaining and managing a local list of RPC Endpoints";
    homepage = "https://github.com/chevdor/subrpc";
    license = licenses.mit;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
