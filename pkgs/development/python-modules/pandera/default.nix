{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pytestCheckHook,
  multimethod,
  numpy,
  packaging,
  pandas,
  pydantic,
  typeguard,
  typing-inspect,
  wrapt,
  # optional dependencies
  black,
  dask,
  fastapi,
  geopandas,
  hypothesis,
  pandas-stubs,
  polars,
  pyyaml,
  scipy,
  shapely,
}:

buildPythonPackage rec {
  pname = "pandera";
  version = "0.20.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "unionai-oss";
    repo = "pandera";
    rev = "v${version}";
    hash = "sha256-VetLfZlBWok7Mr1jxlHHjDH/D5xEsPFWQtX/hrvobgQ=";
  };

  build-system = [ setuptools ];

  dependencies = [
    multimethod
    numpy
    packaging
    pandas
    pydantic
    typeguard
    typing-inspect
    wrapt
  ];

  optional-dependencies =
    let
      dask-dataframe = [ dask ] ++ dask.optional-dependencies.dataframe;
      extras = {
        strategies = [ hypothesis ];
        hypotheses = [ scipy ];
        io = [
          pyyaml
          black
          #frictionless
        ];
        #pyspark = [ pyspark ] ++ pyspark.optional-dependencies.connect;
        #modin = [
        #  modin
        #  ray
        #  dask-dataframe
        #];
        #modin-ray = [
        #  modin
        #  ray
        #];
        #modin-dask = [
        #  modin
        #  dask-dataframe
        #];
        dask = [ dask-dataframe ];
        mypy = [ pandas-stubs ];
        fastapi = [ fastapi ];
        geopandas = [
          geopandas
          shapely
        ];
        polars = [ polars ];
      };
    in
    extras // { all = lib.concatLists (lib.attrValues extras); };

  nativeCheckInputs = [ pytestCheckHook ] ++ optional-dependencies.all;

  pythonImportsCheck = [ "pandera" ];

  meta = {
    description = "A light-weight, flexible, and expressive statistical data testing library";
    homepage = "https://github.com/unionai-oss/pandera";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
