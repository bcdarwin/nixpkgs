{ lib, fetchurl, buildDunePackage, ipaddr, functoria, bos, astring, logs, stdlib-shims, mirage-runtime }:

buildDunePackage rec {

  pname = "mirage";
  version = "3.7.4";

  minimumOCamlVersion = "4.06";

  src = fetchurl {
    url = "https://github.com/mirage/mirage/releases/download/v${version}/${pname}-v${version}.tbz";
    sha256 = "1adrxij0izrrwr026vvifvpswwgr2imbk8h43byhwhw57bnw8kbr";
  };

  propagatedBuildInputs = [ ipaddr functoria bos astring logs stdlib-shims mirage-runtime ];

  # checkInputs = lib.optionals doCheck [ alcotest hex ];

  doCheck = true;

  meta = with lib; {
    homepage = "https://mirage.io/";
    description = "A library operating system";
    license = licenses.isc;
    maintainers = [ maintainers.bcdarwin ];
  };

}
