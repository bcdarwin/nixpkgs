{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  numpy,
}:

buildPythonPackage rec {
  pname = "wquantiles";
  version = "0.6";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "nudomarinero";
    repo = "wquantiles";
    rev = "v${version}";
    hash = "sha256-bvDNm7VXDy2kkpiy6WJ+8j1r/JjDNCZ1MX6zRzj/cS8=";
  };

  build-system = [
    poetry-core
  ];

  dependencies = [
    numpy
  ];

  pythonImportsCheck = [
    "wquantiles"
  ];

  meta = {
    description = "Weighted quantiles with Python";
    homepage = "https://github.com/nudomarinero/wquantiles";
    changelog = "https://github.com/nudomarinero/wquantiles/blob/${src.rev}/CHANGES.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
