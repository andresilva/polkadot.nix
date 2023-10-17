{ lib
, fetchFromGitHub
, openssl
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "subrpc";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "chevdor";
    repo = "subrpc";
    rev = "v${version}";
    hash = "sha256-hxczIUZxPQ0J9T23Rle61Ky08aQKxHuSraA+z3mfaAM=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "jsonrpsee-0.17.0" = "sha256-pnO02JChVcOaueMWyN16dZUn3wHxjgFgn/My7qH/pYI=";
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
