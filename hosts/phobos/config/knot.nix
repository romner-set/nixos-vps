{
  services.knot.settings.server = rec {
    listen = ["162.55.33.86@53" "2a01:4f8:c010:91ac::1@53"];
    listen-quic = ["162.55.33.86@853" "2a01:4f8:c010:91ac::1@853"];
    identity = "ns1.cynosure.red";
    nsid = identity;
  };
}
