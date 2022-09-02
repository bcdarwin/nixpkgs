{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, pytestCheckHook
, pyzmq
, typeguard
, typing-extensions
, globus-sdk
, dill
, tblib
, requests
, paramiko
, psutil
, setproctitle
}:

buildPythonPackage rec {
  pname = "parsl";
  version = "1.2.0";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "Parsl";
    repo = pname;
    rev = version;
    hash = "sha256-83Cd2hyN7eb5kSDv9+aiLt6TxjmtiEXlZvxvqz4mlFs=";
  };

  propagatedBuildInputs = [
    pyzmq
    typeguard
    typing-extensions
    globus-sdk
    dill
    tblib
    requests
    paramiko
    psutil
    setproctitle
  ];

  checkInputs = [
    pytestCheckHook
  ];
  doCheck = false;

  pythonImportsCheck = [ "parsl" ];

  meta = with lib; {
    homepage = "http://parsl-project.org";  # no https
    description = "Parallel and distributed Python scripting library";
    license = licenses.asl20;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
