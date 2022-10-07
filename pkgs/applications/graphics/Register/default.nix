{ stdenv, fetchgit, cmake, netcdf, libminc, hdf5, bicpl, bicgl,
  freeglut, mesa_glu, libGL, libGLU, gle, libX11, libXext, libXi, libXau, libXmu, glew }:

stdenv.mkDerivation rec {
  pname = "Register";
  name  = "${pname}-2017-09-10";

  owner = "BIC-MNI";

  #src = fetchFromGitHub {
  #  inherit owner;
  #  repo   = pname;
  #  rev    = "a391751e0271c18876f9d025ee488949cc7e3974";
  #  sha256 = "1z72d6q9ryv3jaj294bxi8b8ada7is4m2hrgmfm3f4y8b1kpwgv4";
  #};
  src = fetchgit {
    url = "https://github.com/BIC-MNI/Register.git";
    rev    = "a391751e0271c18876f9d025ee488949cc7e3974";
    sha256 = "1fmgrflmz8vz15qz27nalax8l11v8h8pkwy7q9mgkvgas0a97rpn";
  };

  patches = [ ./include_graphics.patch ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [ netcdf hdf5 libminc bicpl bicgl
                  freeglut mesa_glu libGL libGLU gle libX11 libXext libXi libXau libXmu glew ];

  cmakeFlags = [ "-DLIBMINC_DIR=${libminc}/lib"
                 "-DBICPL_DIR=${bicpl}/lib"
                 "-Dbicgl_DIR=${bicgl}/lib"
                 "-DBICGL_INCLUDE_DIR=${bicgl}/include/bicgl"
                 #"-DCMAKE_INCLUDE_PATH=${bicgl}/include"
               ];

  enableParallelBuilding = false;  ##?

  meta = with stdenv.lib; {
    homepage = "https://github.com/${owner}/${pname}";
    description = "Brain Imaging Centre program for visualization and manual registration";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.unix;
    license   = licenses.free;
  };
}
