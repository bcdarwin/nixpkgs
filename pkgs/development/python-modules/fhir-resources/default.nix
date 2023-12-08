{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, pytestCheckHook
, pydantic
}:

buildPythonPackage rec {
  pname = "fhir-resources";
  version = "6.2.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "nazrulworld";
    repo = "fhir.resources";
    rev = "refs/tags/${version}";
    hash = "sha256-7y6a6bOpDLcDP194qH8IB2Sr4jbW/FaNLg7gNN4dX1k=";
  };

  preBuild = ''
    substituteInPlace setup.py --replace '"pytest-runner"' ""
  '';

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [ pydantic ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "fhir.resources" ];

  meta = with lib; {
    description = "FHIR Resources https://www.hl7.org/fhir/resourcelist.html";
    homepage = "https://github.com/nazrulworld/fhir.resources/tree/main";
    license = licenses.bsd3;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
