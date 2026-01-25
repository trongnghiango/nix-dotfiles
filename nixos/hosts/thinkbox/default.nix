{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Nhớ copy file này từ /etc/nixos/ vào
    ../../modules/core.nix
    ../../modules/shell.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
  ];

  hardware.profile = {
    hostType = "laptop";
    cpu = "intel";
    gpu = "intel";
    opengl = true;
    isVirtual = false;
  };
  # Bootloader: Systemd-boot (UEFI). Nếu máy cũ dùng BIOS Legacy, hãy đổi sang Grub.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkbox";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.11";
  # Force rebuild hash
}
