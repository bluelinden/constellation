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
    ./shared/libvirtd-bridge.nix
  ];



  networking.hostName = "barbarian";

  boot.loader.systemd-boot.enable = true;



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
  

  # security.sudo.extraConfig = ''
    # blue ALL=NOPASSWD: ALL
  # '';

  virtualisation = {
    libvirtd = {
      enable = true;
      networking = {
        enable = true;
        bridgeName = "virbr0";
        externalInterface = "enp1s0";
        infiniteLeaseTime = false;
      };
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}