{ lib
, fetchFromGitHub
, openssl
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "subwasm";
  version = "0.21.1";

  src = fetchFromGitHub {
    owner = "chevdor";
    repo = "subwasm";
    rev = "v${version}";
    hash = "sha256-Vxy1l2i+upLHwytsfVjV8IOUC3S0d5kHcS/JtKr7K0U=";
  };

  cargoHash = "sha256-Cjxqs2bUjepB4eH/3m18+toXIhQHUoNUTaNdg7syHeE=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false;

  meta = with lib; {
    description = "CLI utility to inspect a Substrate WASM Runtime";
    homepage = "https://github.com/chevdor/subwasm";
    license = licenses.mit;
    maintainers = with maintainers; [ andresilva ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
