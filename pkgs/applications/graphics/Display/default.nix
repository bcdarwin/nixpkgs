{ stdenv, lib, fetchgit, fetchFromGitHub, cmake, netcdf, libminc, hdf5, bicpl, bicgl,
   freeglut,
  mesa, mesa_glu, libGL, libGLU, gle, libX11, libXext, libXi, libXau, libXmu, glew }:

stdenv.mkDerivation rec {
  pname = "Display";
  version = "unstable-2022-06-25";

  src = fetchFromGitHub {
    owner = "BIC-MNI";
    repo   = pname;
    rev    = "6f267ae0277b058f93faad6af04c9fc70d591b9a";
    hash   = "sha256-+TyoarpHrL9avT8HOy7XIlaG1sZCa5vCH6G9Zt+NW1U=";
  };

  postPatch = ''
     substituteInPlace Include/display_types.h --replace '#include  <graphics.h>' '#include "graphics.h"'
  '';

  #src = fetchgit {
  #  url    = "https://github.com/BIC-MNI/Display.git";
  #  rev    = "22bf5d2a9938bf14131c6eba72c8d9fc152e53f5";
  #  sha256 = "0zng3ir8hx29s6bkx625m40vm5ns5bhfvpap6skmn0y3zj59pcb3";
  #};

  patches = [ ./cmake_package_names.patch ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [ netcdf hdf5 # libminc bicpl bicgl
                  freeglut
                  mesa mesa_glu libGL libGLU gle libX11 libXext libXi libXau libXmu glew libminc bicpl bicgl ];

  cmakeFlags = [
    "-DLIBMINC_DIR=${libminc}/lib/cmake"
    "-Dbicgl_DIR=${bicgl}/lib"
    "-DBICGL_INCLUDE_DIR=${bicgl}/include/bicgl"
    "-DBICPL_INCLUDE_DIR=${bicpl}/include/bicpl"
    "-DGLUT_INCLUDE_DIR=${mesa}/include"
  ];

  enableParallelBuilding = false;

  meta = with lib; {
    homepage = "https://github.com/BIC-MNI/Display";
    description = "Brain Imaging Centre visualization and segmentation program";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.unix;
    license   = licenses.free;
  };
}
