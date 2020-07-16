{ lib
, buildPythonPackage
, fetchFromGitHub
, pytest
, pytestCheckHook
, ignite
, nibabel
, numpy
, parameterized
, pytorch
, scipy
, scikitimage
, torchgpipe
}:

buildPythonPackage rec {
  pname = "monai";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "Project-MONAI";
    repo = "MONAI";
    rev = "${version}";
    sha256 = "0jwhrg308kl0i3riqywgdz2yxv2c7xb79hg7mkmfxa7jms0qpai9";
  };

  propagatedBuildInputs = [ numpy pytorch ];

  checkInputs = [
    ignite nibabel parameterized pytest pytestCheckHook scipy scikitimage torchgpipe
  ];

  meta = with lib; {
    description = "Pytorch framework (based on Ignite) for deep learning in medical imaging";
    homepage = "https://github.com/Project-MONAI/MONAI";
    license = licenses.asl20;
    maintainers = [ maintainers.bcdarwin ];
  };
}
