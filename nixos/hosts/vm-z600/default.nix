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

  # ============================
  # NETWORK (VM)
  # ============================
  networking.networkmanager.enable = true;

  # ============================
  # BOOTLOADER (LEGACY BIOS)
  # ============================
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";   # đĩa virtio của VM
    useOSProber = false;
  };

  # ❌ TẮT HOÀN TOÀN EFI CHO VM
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  # ============================
  # VM OPTIMIZATION
  # ============================

  # Guest tools cho libvirt / virt-manager
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # VirtIO + OpenGL (cho desktop.nix dùng)
  services.xserver.videoDrivers = [ "virtio" ];
  hardware.opengl.enable = true;

  # CPU/RAM tuning nhẹ cho VM
  nix.settings = {
    max-jobs = lib.mkDefault 4;
    cores = lib.mkDefault 4;
  };

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
