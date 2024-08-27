{ fetchFromGitHub
, runCommand
, texliveFull
}:

let
  version = "0.3.6";
in
runCommand "graypaper" {
  inherit version;

  src = fetchFromGitHub {
    owner = "gavofyork";
    repo = "graypaper";
    rev = "v${version}";
    hash = "sha256-Pvk5DgZeRjsen6C4DKZCq1B6ukyiczvSywPRSk22dmA=";
  };
  nativeBuildInputs = [ texliveFull ];
} ''
  mkdir -p $out/share/doc/graypaper

  TMP=$(mktemp -d)
  cp -r $src/* $TMP
  cd $TMP

  xelatex -halt-on-error graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper/graypaper-${version}.pdf

  patch -p1 < ${./printer-friendly.patch}
  xelatex -halt-on-error graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper/graypaper-${version}-printer-friendly.pdf
''
