{ stdenv, fetchzip, expat }:

stdenv.mkDerivation rec {
  pname = "fsl";
  version  = "6.0.3";

  src = fetchzip {
    url = "https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-${version}-sources.tar.gz";
    sha256 = "0b81l3jn3r5cpihi7pkkzdzwd43r44i06g50r9hxn4scr5sdn5lr";
  };

  buildInputs = [ expat ];

  buildPhase = "./build";

  meta = with stdenv.lib; {
    homepage = "https://fsl.fmrib.ox.ac.uk";
    description = "Analysis tools for MRI data";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license = licenses.unfree;
  };
}
