{ stdenv
, buildPythonPackage
, fetchFromGitHub
, numpy
, pillow
, scipy
, setuptools
, vtk_9
, dipy
, matplotlib
, pytestCheckHook }:

buildPythonPackage rec {
  pname = "fury";
  version = "0.6.1";

  #src = fetchPypi {
  #  inherit pname version;
  #  sha256 = "1b9f1vmgh6k73xgc4wf0x37w8ph7qp8ghyqc1a86yw8dd4m11wh6";
  #};

  src = fetchFromGitHub {
    owner = "fury-gl";
    repo = pname;
    rev = "v${version}";
    sha256 = "19b83a5nrkmmqpgq1mkwn7z9m1hkm6a69c8snxn7gmlsn2kn3s17";
  };

  checkInputs = [ dipy matplotlib pytestCheckHook ];  # TODO are dipy/matplotlib tested?
  doCheck = false;  # TODO see https://fury.gl/stable/installation.html

  # https://github.com/NixOS/nixpkgs/issues/84774
  postPatch = ''
    substituteInPlace setup.py --replace "'vtk>=8.1.2,!=9.0.0'," ""
    substituteInPlace requirements/default.txt --replace "vtk>=8.1.2,!=9.0.0" ""
  '';

  propagatedBuildInputs = [ numpy setuptools pillow scipy vtk_9 ];

  meta = with stdenv.lib; {
    description = "Library for scientific visualization in Python";
    homepage = "https://github.com/fury-gl/fury";
    license = licenses.bsd3;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
