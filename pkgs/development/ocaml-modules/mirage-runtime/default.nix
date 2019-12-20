{ lib, fetchurl, buildDunePackage, ipaddr, functoria-runtime, fmt, logs, lwt, mirage }:

buildDunePackage rec {

  pname = "mirage-runtime";
  version = "3.7.4";

  minimumOCamlVersion = "4.06";

  inherit (mirage) src;

  propagatedBuildInputs = [ ipaddr functoria-runtime fmt logs lwt ];

  # checkInputs = lib.optionals doCheck [ alcotest hex ];

  doCheck = true;

  meta = with lib; {
    homepage = "https://mirage.io/";
    description = "A library operating system";
    license = licenses.isc;
    maintainers = [ maintainers.bcdarwin ];
  };

}
