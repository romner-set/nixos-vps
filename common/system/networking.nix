{
  pkgs,
  lib,
  ...
}: {
  systemd.network.enable = true;
  networking.useDHCP = false;

  services.resolved.enable = false;
  networking.resolvconf.enable = lib.mkForce false;
  environment.etc."resolv.conf".text = lib.mkForce ''
    nameserver ::1
    options edns0 trust-ad
  '';

  networking.firewall.allowedTCPPorts = [80 443 444 53];
  networking.firewall.allowedUDPPorts = [443 53 853];
}
