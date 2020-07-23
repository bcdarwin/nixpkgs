{ lib
, buildPythonPackage
, stdenv
, fetchFromGitHub
, pythonOlder
, numpy
, scipy
, vispy
, matplotlib
, pyqt5
, pillow
, pyopengl
, pytestCheckHook
, setuptools
}:

buildPythonPackage rec {
  pname = "visbrain";
  version = "0.4.6";
  disabled = pythonOlder "3.5";

  #src = fetchPypi {
  #  inherit pname version;
  #  sha256 = "19kf4ykkyplk9n7hn190s30z7n7iamwjj3a5ylggl7wpwvlrcm8v";
  #};
  src = fetchFromGitHub {
    owner = "EtienneCmb";
    repo = pname;
    rev = "911c6ad5cb9b29c185502070e2ffa9ec59cf5ed0";  # no tag with version bump
    sha256 = "13ksfq4497gwp67z089i6klrdlsn8cgnbsi3r0n9wfyz0rha1k3g";
  };

  #patches = [
  #  (substituteAll {
  #    src = ./library-paths.patch;
  #    fontconfig = "${fontconfig.lib}/lib/libfontconfig${stdenv.hostPlatform.extensions.sharedLibrary}";
  #    gl = "${libGL.out}/lib/libGL${stdenv.hostPlatform.extensions.sharedLibrary}";
  #  })
  #];

  propagatedBuildInputs = [
    numpy scipy vispy matplotlib pyqt5 pillow pyopengl setuptools
  ];


  doCheck = false;
  pythonImportsCheck = [ "visbrain" "visbrain.io" "visbrain.objects" "visbrain.utils" ];
  checkInputs = [ pytestCheckHook ];

  meta = with lib; {
    homepage = "https://visbrain.org";
    description = "Interactive scientific visualization in Python";
    license = licenses.bsd3;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
