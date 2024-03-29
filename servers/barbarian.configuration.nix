# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hw/barbarian.hardware.nix
    ./all.nix
    ../services/ghost/docker-compose.nix
    # ./shared/libvirtd-bridge.nix
  ];



  networking.hostName = "barbarian";

  boot.loader.systemd-boot.enable = true;

  # set time zone 
  time.timeZone = "America/New_York";





  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  environment.systemPackages = with pkgs; [
    # For virt-install
    virt-manager

    # For lsusb
    usbutils
  ];

  # FIXME: enable this!! figure out why it's #brocken
  networking.firewall = {
    enable = false;
    extraCommands = ''
      # iptables -N ACCEPT_TCP_UDP
      iptables -A ACCEPT_TCP_UDP -p tcp -j ACCEPT
      iptables -A ACCEPT_TCP_UDP -p udp -j ACCEPT



      iptables -A nixos-fw -d 192.168.1.41 -j ACCEPT_TCP_UDP

      
      iptables -t nat -A PREROUTING -d 192.168.1.41 -p tcp -m tcp --dport 1:65535 -m comment --comment "Home Assistant Port Forwarding" -j DNAT --to-destination 192.168.122.70:1-65535
      iptables -t nat -A PREROUTING -d 192.168.1.41 -p udp -m udp --dport 1:65535 -m comment --comment "Home Assistant Port Forwarding" -j DNAT --to-destination 192.168.122.70:1-65535
    '';
  };

  systemd.services.openHassioPort = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      /run/current-system/sw/bin/iptables -t nat -A PREROUTING -d 192.168.1.41 -p tcp -m tcp --dport 1:65535 -m comment --comment "Home Assistant Port Forwarding" -j DNAT --to-destination 192.168.122.70:1-65535
      /run/current-system/sw/bin/iptables -t nat -A PREROUTING -d 192.168.1.41 -p udp -m udp --dport 1:65535 -m comment --comment "Home Assistant Port Forwarding" -j DNAT --to-destination 192.168.122.70:1-65535
    '';
  };

  networking.defaultGateway  = "192.168.1.1";
  networking.interfaces."enp1s0".ipv4 = {
    addresses = [
      {
        address = "192.168.1.244";
        prefixLength = 24;
      }
    ];
    routes = [
      {
        address = "192.168.1.0";
        via = "192.168.1.1";
        prefixLength = 24;
      }
      # {
      #   address = "192.168.122.0";
      #   via = "192.168.122.1";
      #   prefixLength = 24;
      # }
    ];
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
  

  # security.sudo.extraConfig = ''
    # blue ALL=NOPASSWD: ALL
  # '';

  services.cloudflared = {
    enable = true;
    group = "users";
    user = "blue";
    tunnels = {
      web = {
        ingress = {
          "bluelinden.art" = "http://localhost:2368";
          "ghost.bluelinden.art" = "http://localhost:2368";
          "analytics.bluelinden.art" = "http://localhost:8000";
        };
        credentialsFile = "/home/blue/.cloudflared/586d467c-b149-4a91-9fa2-4f6b17b289c6.json";
        default = "http_status:404";
      };
    };
  };

  services.plausible = {
    enable = true;
    mail.email = "plausiblemail@bluelinden.art";
    server.disableRegistration = "invite_only";
    server.port = 8000;
    server.baseUrl = "https://analytics.bluelinden.art";
    server.secretKeybaseFile = "/etc/plausible/phx-secret.txt";
    adminUser.name = "blue";
    adminUser.email = "plausible@bluelinden.art";
    adminUser.passwordFile = "/etc/plausible/admin-password.txt";
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      # networking = {
      #   enable = true;
      #   bridgeName = "virbr0";
      #   externalInterface = "enp1s0";
      #   infiniteLeaseTime = false;
      # };
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}