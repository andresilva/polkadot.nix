{ lib
, fetchFromGitHub
, rustPlatform
, openssl
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "subwasm";
  version = "0.21.3";

  src = fetchFromGitHub {
    owner = "chevdor";
    repo = "subwasm";
    rev = "v${version}";
    hash = "sha256-cBy/gkJjZjODcuzniYztZJNUSbujmUsr2ma5XADRcMU=";

    # the build process of subwasm requires a .git folder in order to determine
    # the git commit hash that is being built and add it to the version string.
    # since having a .git folder introduces reproducibility issues to the nix
    # build, we check the git commit hash after fetching the source and save it
    # into a .git_commit file, and then delete the .git folder. we can then use
    # this file to populate an environment variable with the commit hash, which
    # is picked up by subwasm's build process.
    leaveDotGit = true;
    postFetch = ''
      ( cd $out; git rev-parse --short HEAD > .git_commit )
      rm -rf $out/.git
    '';
  };

  preBuild = ''
    export SUBWASM_CLI_GIT_COMMIT_HASH=$(< .git_commit)
    rm .git_commit
  '';

  cargoHash = "sha256-XWcNONLjoEb0+6gEut8teIbQlZQt6x+++3AXUGcMrxQ=";

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
