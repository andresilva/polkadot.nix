{ lib
, fetchFromGitHub
, openssl
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage {
  pname = "subwasm";
  version = "0.20.0";

  src = fetchFromGitHub {
    owner = "andresilva";
    repo = "subwasm";
    rev = "08b9496e9230e410593977dd2396b0917f028f62"; # v${version}
    hash = "sha256-Kq/W2knfI2sZ96Uqqv/Fj1v47uVL6i4RpWaQa96w728=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "sc-allocator-4.1.0-dev" = "sha256-QPil2OAH3Oo1ZBlCGygCvdi6jbvkwQRl0GC7ogTw7nI=";
    };
  };

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
