{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  domain = "starless.one";
  quic-key = "qPn4VWWN4MlloImery9UMfDVE5QElGEXM0M60kBcpig="; # public cert of primary server, safe to expose
in {
  # KnotDNS
  systemd.services.knot.serviceConfig.BindPaths = ["/data/knot"];
  services.knot = {
    enable = true;
    settings = {
      server = rec {
        version = "KnotDNS";
        tcp-io-timeout = 100;
        tcp-reuseport = "on"; # enable only on secondaries
        #automatic-acl = "on";
      };

      database.storage = "/data/knot";

      mod-rrl = [
        {
          id = "default";
          rate-limit = 1000;
          slip = 2;
        }
      ];

      remote = [
        {
          id = "primary";
          address = ["::1@853"];
          cert-key = quic-key;
          quic = "on";
        }
      ];

      template = [
        {
          id = "default";
          global-module = "mod-rrl/default";
          journal-content = "all";
          zonefile-sync = -1;
          zonefile-load = "none";
          dnssec-validation = "on";
          #zonemd-generate = "zonemd-sha512";
          serial-policy = "dateserial";
        }
      ];

      zone = [
        {
          domain = domain;
          master = "primary";
          acl = "allow-primary";
        }
      ];

      acl = [
        {
          id = "allow-primary";
          cert-key = quic-key;
          action = ["transfer" "notify"];
        }
      ];
    };
  };
}
