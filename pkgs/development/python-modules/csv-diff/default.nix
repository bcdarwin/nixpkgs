{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pytestCheckHook,
  click,
  dictdiffer,
}:

buildPythonPackage rec {
  pname = "csv-diff";
  version = "1.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "simonw";
    repo = "csv-diff";
    rev = version;
    hash = "sha256-l8cLmtH7ABe0bx0+3x7Or8SE6OcoA/YkXY2nGEDqIU0=";
  };

  postPatch = ''
    substituteInPlace setup.py --replace-fail '["pytest-runner"]' '[]' 
  '';

  build-system = [
    setuptools
  ];

  dependencies = [
    click
    dictdiffer
  ];

  pythonImportsCheck = [
    "csv_diff"
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  meta = {
    description = "Python CLI tool and library for diffing CSV and JSON files";
    homepage = "https://github.com/simonw/csv-diff";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
