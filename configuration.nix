{ pkgs, inputs, ... }:
{
  imports = [
    ./main.nix
    ./hardware-configuration.nix
   ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # not a partition like /dev/sda1

  networking.hostName = "nixos";
  networking.useDHCP = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    helix
    xray
    blahaj
    eza
    git
  ];


  users.users.oli = {
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" ];
};

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.firewall.allowedTCPPorts = [ 443 53 10808 ];
  networking.firewall.allowedUDPPorts = [ 443 53 10808 ];

  time.timeZone = "UTC";
  system.stateVersion = "24.05"; # or the version you’re installing
}
