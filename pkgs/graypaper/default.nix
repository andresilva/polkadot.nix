{
  fetchFromGitHub,
  runCommand,
  texliveBasic,
}:

let
  version = "0.5.3";
in
runCommand "graypaper"
  {
    inherit version;

    src = fetchFromGitHub {
      owner = "gavofyork";
      repo = "graypaper";
      rev = "v${version}";
      hash = "sha256-9xiKgnKVx9p291Ky3ZJWYFco9Sp2WilKdqUvWjtzYbo=";
    };
    nativeBuildInputs = [
      (texliveBasic.withPackages (
        ps: with ps; [
          biber
          biblatex
          booktabs
          caption
          cellspace
          changepage
          collection-fontsextra
          eso-pic
          jknapltx
          makecell
          mathabx
          mathtools
          mnsymbol
          multirow
          pagecolor
          pgf
          relsize
          stackengine
          subfig
          units
          xetex
        ]
      ))
    ];
  }
  ''
    mkdir -p $out/share/doc/graypaper

    TMP=$(mktemp -d)
    cp -r $src/* $TMP
    cd $TMP

    xelatex -halt-on-error graypaper
    biber graypaper
    xelatex -halt-on-error graypaper
    mv graypaper.pdf $out/share/doc/graypaper/graypaper-${version}.pdf

    patch -p1 < ${./printer-friendly.patch}
    xelatex -halt-on-error graypaper
    biber graypaper
    xelatex -halt-on-error graypaper
    mv graypaper.pdf $out/share/doc/graypaper/graypaper-${version}-printer-friendly.pdf
  ''
