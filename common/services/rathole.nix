{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [rathole];

  systemd.services.rathole = {
    description = "rathole service";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.rathole}/bin/rathole /data/rathole.toml";
      Restart = "on-failure";
    };
    wantedBy = ["default.target"];
  };
}
