{ lib
, buildPythonPackage
, fetchPypi
#, fetchFromGitHub
, isPy27
, git
, git-annex
, nose
, beautifulsoup4
, httpretty
, vcrpy
, appdirs
, chardet
, distro
, GitPython
, iso8601
, humanize
, fasteners
, patool
, tqdm
, wrapt
, annexremote
, boto
, keyring
, keyrings-alt
, msgpack
, requests
, jsmin
, PyGithub
, simplejson
, whoosh
}:

buildPythonPackage rec {
  pname = "datalad";
  version = "0.12.6";

  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "0xrp8phcx3g0nwn0la5mnfy0bnvipj4ppkny2zkv9dnn4cjz92vz";
  };
  #src = fetchFromGitHub {
  #  owner = "datalad";
  #  repo = pname;
  #  rev = version;
  #  sha256 = "0y9mfhp9kycgama0b23vzg187jn4ly5dg1r3n5izh8zj0dry8sl3";
  #};

  propagatedBuildInputs = [
    git git-annex
    appdirs chardet GitPython distro iso8601
    humanize fasteners patool tqdm wrapt annexremote
    boto keyring keyrings-alt msgpack requests
    jsmin PyGithub simplejson whoosh
  ];  # TODO git-annex?

  checkInputs = [ nose git git-annex beautifulsoup4 httpretty vcrpy ];
  checkPhase = "nosetests";

  meta = with lib; {
    homepage = "https://datalad.org";
    description = "Keep scientific data under control with git and git-annex";
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
