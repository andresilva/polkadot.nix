{ fetchFromGitHub
, runCommand
, texliveFull
}:

runCommand "graypaper"
{
  version = "unstable-2024-05-29";
  src = fetchFromGitHub {
    owner = "gavofyork";
    repo = "graypaper";
    rev = "5efa7278d767792b925800b6288f197c8afdc5af";
    sha256 = "16w2aqi02962p0s3rh6m1xbmj3cg327hj5lpix4vv1p6ygwhrckh";
  };
  nativeBuildInputs = [ texliveFull ];
} ''
  mkdir -p $out/share/doc/graypaper

  TMP=$(mktemp -d)
  cp -r $src/* $TMP
  cd $TMP

  xelatex graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper

  patch -p1 < ${./printer-friendly.patch}
  xelatex graypaper.tex
  mv graypaper.pdf $out/share/doc/graypaper/graypaper-printer-friendly.pdf
''
