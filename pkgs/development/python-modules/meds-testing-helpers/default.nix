{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  annotated-types,
  hydra-core,
  meds,
  numpy,
  polars,
  pyarrow,
  pytestCheckHook,
  pytimeparse,
  pytest-cov-stub,
}:

buildPythonPackage rec {
  pname = "meds-testing-helpers";
  version = "0.2.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Medical-Event-Data-Standard";
    repo = "meds_testing_helpers";
    rev = version;
    hash = "sha256-KgT6BBpSV5QIx/V1DPreXiBpweuABlLyRu9+TfgIvU4=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    annotated-types
    hydra-core
    meds
    numpy
    polars
    pyarrow
    pytimeparse
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-cov-stub
  ];

  preCheck = ''cd src/'';

  pythonImportsCheck = [
    "meds_testing_helpers"
  ];

  meta = {
    description = "Testing, benchmarking, and synthetic data generation helpers for MEDS tools, pipelines, and models";
    homepage = "https://meds-testing-helpers.readthedocs.io";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
