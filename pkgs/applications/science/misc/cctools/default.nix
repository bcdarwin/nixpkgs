{ stdenv
, lib
, fetchurl
, fetchpatch
, zlib
, coreutils
, which
, swig
, perl
, python3
}:

stdenv.mkDerivation rec {
  pname = "cctools";
  version = "7.4.1";

  src = fetchurl {
    url = "https://ccl.cse.nd.edu/software/files/cctools-${version}-source.tar.gz";
    sha256 = "sha256-yTwm+Eml0BFfR3ic2jtHKeJrmN4U7ifKEzVEx7JUOhQ=";
  };

  postPatch = ''
    patchShebangs ./run_all_tests.sh
    patchShebangs makeflow/src/starch
    find . -name 'TR_*' | while read t; do patchShebangs $t; done
    find . -name '*.sh' | while read f; do substituteInPlace $f --replace /bin/echo ${coreutils}/bin/echo; done
    find . -name '*.makeflow' | while read f; do substituteInPlace $f --replace /bin/echo ${coreutils}/bin/echo; done
    for f in makeflow/test/syntax/quotes.01.makeflow makeflow/test/syntax/category_variable_scope.makeflow makeflow/test/TR_makeflow_025_quoting.sh work_queue/test/TR_work_queue_python.sh; do substituteInPlace $f --replace /bin/echo ${coreutils}/bin/echo; done
    rm chirp/test/TR_chirp_ops.sh  # hangs
  '';

  nativeBuildInputs = [ swig ];
  buildInputs = [ zlib perl python3 ];  # TODO python3 not really needed; perl - propagate?

  # TODO test failure doesn't cause propagate to cause build failure!
  #doCheck = true;
  checkInputs = [ which coreutils ];

  meta = with lib; {
    description = "Tools for large scale distributed computation";
    homepage = "https://ccl.cse.nd.edu/";
    license = lib.licenses.gpl2;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
