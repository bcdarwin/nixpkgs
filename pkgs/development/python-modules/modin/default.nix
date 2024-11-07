{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pytestCheckHook,
  pytest-cov-stub,
  fsspec,
  numpy,
  pandas,
  packaging,
  psutil,
  # test
  boto3,
  fastparquet,
  matplotlib,
  polars,
  scipy,
  sqlalchemy,
  s3fs,
  #optional dependencies
  dask,
  distributed,
  pyarrow,
  ray,
}:

buildPythonPackage rec {
  pname = "modin";
  version = "0.32.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "modin-project";
    repo = "modin";
    rev = version;
    hash = "sha256-c7V+zqiFmc0o6TRR3zsNEjf7h++Pgmb6sl/p95Cxa40=";
  };

  build-system = [ setuptools ];

  dependencies = [
    fsspec
    numpy
    pandas
    packaging
    psutil
  ];

  optional-dependencies =
    let
      extras = {
        dask = [
          dask
          distributed
        ];
        ray = [
          ray
          pyarrow
        ];
        #mpi = [ unidist ] ++ unidist.optional-dependencies.mpi;
      };
    in
    extras // { all = lib.concatLists (lib.attrValues extras); };

  pythonImportsCheck = [ "modin" ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-cov-stub
    boto3
    fastparquet
    matplotlib
    polars
    scipy
    sqlalchemy
    s3fs
  ] ++ optional-dependencies.all;

  pytestFlagsArray = [ "modin/tests" ];

  disabledTestPaths = [
    "modin/tests/core/storage_formats/cudf"
    "modin/tests/experimental"
    "modin/tests/pandas/integrations/test_lazy_import.py"
    "modin/tests/core/storage_formats/pandas/test_internals.py" # non-unique filename
  ];

  meta = with lib; {
    description = "Modin: Scale your Pandas workflows by changing a single line of code";
    homepage = "https://github.com/modin-project/modin";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
