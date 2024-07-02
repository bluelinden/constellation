{ pkgs, ... }:

{

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # system.copySystemConfiguration = true;


  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };



  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  networking.networkmanager.enable = true;

  nix.settings.trusted-users = [ "root" "blue" "@wheel" ];
  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.blue = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      micro
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    interactiveShellInit = ''
      printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh"}}\x9c'
    '';
  };



  services.tailscale = {
    enable = true;
    package = pkgs.tailscale;
    openFirewall = true;
    interfaceName = "bluenet0";
  };
  networking.firewall.trustedInterfaces = [ "bluenet0" ];

  environment.systemPackages = with pkgs; [
    nodejs
    mosh
    pciutils
    htop
    tmux
  ];

}
