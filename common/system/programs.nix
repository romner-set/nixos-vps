{
  config,
  lib,
  pkgs,
  ...
}: {
  ### PROGRAMS ###
  programs = {
    fish.enable = true;
    fish.promptInit = "${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source";
    nano.enable = false; # ew
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  #services.tor.enable = true;
  #services.tor.client.enable = true;

  ### PACKAGES ###
  environment.systemPackages = with pkgs; [
    # security
    crowdsec
    #iptables
    #ipset

    # idiot-proofing
    molly-guard

    # essential
    neofetch
    btop
    wget
    kitty.terminfo
    #meslo-lgs-nf
    git
    any-nix-shell

    # misc tools
    du-dust
    nmap
    ldns
    sysstat
    sops
    openssl
    bridge-utils
    gptfdisk
    termshark
    rsync
    wget
    btrfs-progs
    p7zip
    zip
    unzip
    xz
    ripgrep
    jq
    iperf3
    ipcalc
    tree
    ltrace
    strace
    lsof
    usbutils
    pciutils
    p7zip
  ];
}
