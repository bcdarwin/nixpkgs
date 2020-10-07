{ stdenv, fetchFromGitHub, cmake, boost, libxmlxx, qt5 }:

stdenv.mkDerivation rec {
  pname = "ciftilib";
  version = "unstable-2020-10-06";

  src = fetchFromGitHub {
    owner = "Washington-University";
    repo = "CiftiLib";
    rev = "10c99a58f44996ad26344be531ebd699cc0c8d31";
    sha256 = "0h0gh2dwnxkhkjwilkjkm8n7bf0asxxc6zs5c0rjmq8yrfj9vkf5";
  };

  #cmakeFlags = [ "-DDOWNLOAD_TEST_DATA=OFF" ];

  nativeBuildInputs = [ boost cmake ];
  buildInputs = [ libxmlxx qt5.qtbase ];

  #checkPhase = ''
  #  runHook preCheck
  #  ctest -LE 'NEEDS_DATA'
  #  runHook postCheck
  #'';
  doCheck = true;

  meta = with stdenv.lib; {
    homepage = "https://github.com/Washington-University/CiftiLib";
    description = "Library for reading and writing CIFTI files";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.unix;
    license = licenses.bsd2;
  };
}
