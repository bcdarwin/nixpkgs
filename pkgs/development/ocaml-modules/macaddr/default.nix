{ stdenv, fetchurl, buildDunePackage, ounit, ppx_sexp_conv, ipaddr }:

buildDunePackage rec {
  pname = "macaddr";

  inherit (ipaddr) src version;

  propagatedBuildInputs = [ ppx_sexp_conv ];
  checkInputs = [ ounit ];

  doCheck = true;

  meta = ipaddr.meta // { description = "Library for manipulating MAC address representations"; };

}
