{ stdenv, fetchgit, cmake, flex, bison, which,
  fftwFloat, freeglut, gsl, hdf5, mesa, netcdf,
  pcre, perl, octave, libXext, libXi, libXmu, zlib }:

stdenv.mkDerivation rec {
  _name    = "minc-toolkit";
  _version = "1.0.07";
  name = "${_name}-${_version}";

  # fetchFromGitHub doesn't seem to check out submodules properly ...
  src = fetchgit {
    url = "https://github.com/BIC-MNI/${_name}.git";
    rev = "9dbb6ed";
    sha256 = "0z9z0fa1g273r3yxi1nfyv0gri9fch79nbnlynyr27v9ckmj3v3y";
  };
  
  nativeBuildInputs = [ cmake flex bison which ];
  buildInputs = [ perl fftwFloat freeglut gsl hdf5 mesa netcdf octave pcre libXext libXmu libXi zlib ];

  patches = [ ./include-external-project.patch ];

  configurePhase = ''
    mkdir build/
    cd build/
    cmake -DCMAKE_INSTALL_PREFIX=$out $cmakeFlags ../
  '';

  dontSetPrefix = true;

  cmakeFlags = [
    #"-DCMAKE_INSTALL_PREFIX=$out"

    "-DMT_BUILD_SHARED_LIBS=ON"

    "-DUSE_SYSTEM_FFTW3F=ON"
    "-DUSE_SYSTEM_GSL=ON"
    "-DUSE_SYSTEM_HDF5=ON"
    #"-DUSE_SYSTEM_ITK=ON"    # doesn't work due to bug #36
    "-DUSE_SYSTEM_NETCDF=ON"
    "-DUSE_SYSTEM_PCRE=ON"
    "-DUSE_SYSTEM_ZLIB=ON"

    #"-DMT_BUILD_VISUAL_TOOLS=ON"
    #"-DMT_BUILD_ITK_TOOLS=ON"
    #"-DMT_BUILD_MINC_ANTS=ON"
    #"-DMT_BUILD_C3D=ON"
  ];

  checkPhase = "ctest";  # note that tests won't succeed due to failure of nonlinear minctracc test

  meta = {
    description = "Metaproject bundling most MINC libraries and tools";
    license     = "GPL3";
    homepage    = "https://github.com/BIC-MNI/${_name}";
  };
}
