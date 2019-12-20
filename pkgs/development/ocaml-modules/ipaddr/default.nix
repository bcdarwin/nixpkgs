{ stdenv, fetchurl, buildDunePackage, ounit, ppx_sexp_conv, domain-name, macaddr, stdlib-shims }:

buildDunePackage rec {
  pname = "ipaddr";
  version = "4.0.0";

  src = fetchurl {
    url = "https://github.com/mirage/ocaml-${pname}/releases/download/v${version}/${pname}-v${version}.tbz";
    sha256 = "0agwb4dy5agwviz4l7gpv280g1wcgfl921k1ykfwq80b46fbyjkg";
  };

  checkInputs = [ ounit ppx_sexp_conv ];
  propagatedBuildInputs = [ domain-name macaddr stdlib-shims ];

  doCheck = true;

  meta = with stdenv.lib; {
    homepage = https://github.com/mirage/ocaml-ipaddr;
    description = "A library for manipulation of IP address representations";
    license = licenses.isc;
    maintainers = [ maintainers.ericbmerritt ];
  };
}
