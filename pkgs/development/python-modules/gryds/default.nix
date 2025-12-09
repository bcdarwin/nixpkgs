{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pytestCheckHook,
  numpy,
  scipy,
}:

buildPythonPackage rec {
  pname = "gryds";
  version = "unstable-2019-07-31";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tueimage";
    repo = "gryds";
    rev = "cda4bac8f71e8bb47fc632b8cdea010904ae5cf1";
    hash = "sha256-jFHdUmFK8dAmG0seTScsIgB1ogBIPA+yz07XU5n+ejQ=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    numpy
    scipy
  ];

  pythonImportsCheck = [
    "gryds"
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  meta = {
    description = "A Python package for geometric transformations of images for data augmentation in deep learning";
    homepage = "https://github.com/tueimage/gryds";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
  };
}
