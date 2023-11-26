{ lib
, buildPythonPackage
, fetchFromGitHub
, flit-core
, hypothesis
, pytestCheckHook
, pytest-helpers-namespace
, cachetools
, codetiming
, ipywidgets
, numpy
, pandas
, pillow
, psycopg2
, scikitlearn
, scipy
, sqlalchemy
, sqlmodel
, typing-extensions
}:

buildPythonPackage rec {
  pname = "superintendent";
  version = "0.6.0";
  pyproject = true;

  # disabled = ...

  src = fetchFromGitHub {
    owner = "janfreyberg";
    repo = "superintendent";
    rev = "refs/tags/v${version}";
    hash = "sha256-RgilQbsFs7b0I7o2rWj04cYP1YJ+5L16pjLUA7s+wmE=";
  };

  preBuild = ''
    substituteInPlace pyproject.toml --replace 'requires = ["flit_core >=2,<3"]' 'requires = ["flit_core >=2"]'
  '';

  nativeBuildInputs = [
    flit-core
  ];

  propagatedBuildInputs = [
    cachetools
    codetiming
    ipywidgets
    numpy
    pandas
    pillow
    psycopg2
    scikitlearn
    scipy
    sqlalchemy
    sqlmodel
    typing-extensions
  ];

  nativeCheckInputs = [
    pytestCheckHook
    hypothesis
    pytest-helpers-namespace
  ];

  pythonImportsCheck = [
    "superintendent"
    "superintendent.acquisition_functions"
  ];

  meta = with lib; {
    description = "Practical active learning in python";
    homepage = "https://superintendent.readthedocs.io";
    # changelog = ...;
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
