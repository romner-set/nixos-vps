{
  # OpenSSH
  services.openssh = {
    enable = true;
    openFirewall = true;
    ports = [31832]; # chosen with 5 fair d10 dice rolls
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    extraConfig = ''
      TCPKeepAlive yes
      ClientAliveInterval 60
      ClientAliveCountMax 5
    '';
  };

  # endlessh
  services.endlessh-go.enable = true;
  services.endlessh-go.port = 22;
}
