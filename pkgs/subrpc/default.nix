{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "subrpc";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "chevdor";
    repo = "subrpc";
    rev = "v${version}";
    hash = "sha256-o67+ohL4CWou8HGeitI5IniuY5B5/HB019wKg+E8dbQ=";
  };

  cargoHash = "sha256-y0bND+ncfa1bfl1Pz/HlcXNcYfyPUnzf43ihRxYs76A=";

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
