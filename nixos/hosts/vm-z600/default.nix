{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/shell.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
  ];

  networking.hostName = "vm-z600";

  # Network cho VM
  networking.networkmanager.enable = true;

  # Bootloader (VM dùng UEFI là ổn nhất)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ============================
  # TỐI ƯU RIÊNG CHO VM
  # ============================

  # Guest profile (virtio, balloon, spice)
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # CPU tối ưu cho host Xeon
  nix.settings.max-jobs = lib.mkDefault 8;
  nix.settings.cores = lib.mkDefault 8;

  # Tối ưu RAM cho VM
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };

  # Log gọn cho VM
  services.journald.extraConfig = ''
    SystemMaxUse=200M
    RuntimeMaxUse=100M
  '';

  system.stateVersion = "25.11";
}
