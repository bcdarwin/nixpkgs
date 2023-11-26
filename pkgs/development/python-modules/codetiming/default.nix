{ lib
, buildPythonPackage
, fetchFromGitHub
, flit-core
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "codetiming";
  version = "1.4.0";
  pyproject = true;

  # disabled = ...

  src = fetchFromGitHub {
    owner = "realpython";
    repo = "codetiming";
    rev = "refs/tags/v${version}";
    hash = "sha256-u7uW4eo1TCBSTCTqxtKA3pFdQQxinSQ5CWMwOeIswYY=";
  };

  nativeBuildInputs = [ flit-core ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "codetiming" ];

  meta = with lib; {
    description = "A flexible, customizable timer for your Python code";
    homepage = "https://github.com/realpython/codetiming";
    changelog = "https://github.com/realpython/codetiming/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
