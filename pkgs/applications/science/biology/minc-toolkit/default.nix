{ stdenv, fetchgit, cmake, pkgconfig, flex, bison, which,
  fftwFloat, freeglut, gsl, hdf5, itk, mesa, netcdf,
  pcre, perl, octave, libXext, libXi, libXmu, zlib }:

stdenv.mkDerivation rec {
  _name    = "minc-toolkit";
  _version = "1.9.11";
  name = "${_name}-${_version}";

  # fetchFromGitHub doesn't seem to check out submodules properly ...
  src = fetchgit {
    url = "https://github.com/BIC-MNI/${_name}-v2.git";
    rev = "8e57f87a33fa0";
    sha256 = "03xac5wwlpvpqkkn3pg7h5f0ds9qchy85q2bhsp8x5zh4rh1lvk8";
  };
  
  nativeBuildInputs = [ cmake pkgconfig flex bison which ];
  buildInputs = [ perl fftwFloat freeglut gsl hdf5 itk mesa netcdf octave pcre libXext libXmu libXi zlib ];

  #patches = [ ./include-external-project.patch ];  # not needed while USE_SYSTEM_ITK is OFF (see below)
  #patches = [ ./include-external-project.patch ./no-skip-rpath.patch ];
  # FIXME remove these commented lines
  patches = [ ./no-add-dependencies.patch ];

  configurePhase = ''
    mkdir build/
    cd build/
    cmake -DCMAKE_INSTALL_PREFIX=$out $cmakeFlags ../
  '';

  checkTarget = "test";
  # doCheck = true;

  cmakeFlags = [
    "-DMT_BUILD_SHARED_LIBS=ON"

    "-DUSE_SYSTEM_FFTW3F=ON"
    "-DUSE_SYSTEM_GSL=ON"
    "-DUSE_SYSTEM_HDF5=ON"
    "-DUSE_SYSTEM_ITK=ON" "-DITK_DIR=${itk}/lib/cmake"   # doesn't work due to minc-toolkit bug #36
    "-DUSE_SYSTEM_NETCDF=ON"
    "-DUSE_SYSTEM_PCRE=ON"
    "-DUSE_SYSTEM_ZLIB=ON"

    #"-DMT_BUILD_VISUAL_TOOLS=ON"
    #"-DMT_BUILD_ITK_TOOLS=ON"
    #"-DMT_BUILD_ANTS=ON"
    #"-DMT_BUILD_C3D=ON"
  ];

  meta = {
    description = "Metaproject bundling most MINC libraries and tools, 'version 2'";
    license     = "GPL3";
    homepage    = "https://github.com/BIC-MNI/${_name}-v2";
  };
}
