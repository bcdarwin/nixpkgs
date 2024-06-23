{ lib
, stdenv
, fetchFromGitHub
, cmake
, gfortran
, python3
, itk
, libGL
, libGLU
, libX11
, libXi
, libXmu
, libXt
, vtk
, zlib
, xxd
}:

stdenv.mkDerivation rec {
  pname = "freesurfer";
  version = "7.4.1";

  src = fetchFromGitHub {
    owner = "freesurfer";
    repo = "freesurfer";
    rev = "refs/tags/v${version}";
    hash = "sha256-6I/E49zYupKHs0HP54yoazoeXJ5zrLNPh7W2XAbyD88=";
  };

  nativeBuildInputs = [
    cmake
    gfortran
    python3  # TODO move to buildInputs ?
    xxd
  ];

  buildInputs = [
    itk
    vtk
    zlib
    libGL
    libGLU
    libX11
    libXi
    libXmu
    libXt
  ];

  cmakeFlags = [ "-DBUILD_GUIS=OFF" ];

  meta = with lib; {
    description = "Neuroimaging analysis and visualization suite";
    homepage = "https://github.com/freesurfer/freesurfer/releases/tag/v7.4.1";
    license = licenses.free;  # freesurfer license v1.0; seems to be a free license
    maintainers = with maintainers; [ ];
    mainProgram = "recon-all";
    platforms = platforms.linux;
  };
}
