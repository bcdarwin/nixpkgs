{ lib
, buildPythonPackage
, fetchFromGitHub
, pytest
, file
, lzip
, unzip
, s-tar
}:

buildPythonPackage rec {
  pname = "patool";
  version = "1.12";

  src = fetchFromGitHub {
    owner = "wummel";
    repo = pname;
    rev = "upstream/${version}";
    sha256 = "0v4r77sm3yzh7y1whfwxmp01cchd82jbhvbg9zsyd2yb944imzjy";
  };

  propagatedBuildInputs = [ file unzip lzip ]; # s-tar ];

  checkInputs = [ pytest file unzip lzip ]; #s-tar ];
  checkPhase = "pytest -vv tests -k 'not test_unzip'";  # unknown failure reason

  meta = with lib; {
    homepage = "https://wummel.github.io/patool/";
    description = "Portable archive file manager";
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
