{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
  };

    nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };


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


  nix.settings.trusted-users = [ "root" "blue" "@wheel" ];
  security.sudo.wheelNeedsPassword = false;
  services.openssh.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.blue = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
       tree
       micro
    ];
  };

}