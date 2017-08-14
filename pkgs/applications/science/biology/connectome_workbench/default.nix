{ stdenv, lib, fetchFromGitHub, cmake, libGL, libGLU, mesa, qt5 }:

stdenv.mkDerivation rec {
  pname = "connectome_workbench";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner  = "Washington-University";
    repo   = "workbench";
    rev    = "v${version}";
    sha256 = "Ntex9dxJvrVsw5kj23yliDiCTZCQwHaEwo/0IdybP/s=";
  };

  nativeBuildInputs = [ cmake qt5.wrapQtAppsHook ]; # ++ (if doCheck then [ perl ] else [ ]);
  buildInputs = [ libGL libGLU mesa qt5.qtbase ];  # mesa -> native ?

  #preConfigure = ''
  #  mkdir build
  #  cd build
  #'';
  cmakeFlags = [ "-DCMAKE_BUILD_TESTING=OFF" "../src" ];

  #cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" "-DWORKBENCH_USE_QT5=TRUE" "../src" ];

  meta = with lib; {
    homepage    = https://github.com/Washington-University/workbench/;   # TODO fix
    description = "TODO";
    maintainers = with maintainers; [ bcdarwin ];
    platforms   = platforms.linux;
    license     = licenses.gpl2;  # and others ?!
  };
}
