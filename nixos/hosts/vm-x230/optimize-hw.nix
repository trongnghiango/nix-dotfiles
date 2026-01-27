{ config, pkgs, isEfi, ... }:

{
  # --- 1. BOOTLOADER (Dựa trên thông số từ Flake) ---
  boot.loader = if isEfi then {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 3; # Máy ảo nên để ít generation cho nhẹ ổ đĩa
  } else {
    grub = {
      enable = true;
      # Trong máy ảo QEMU thường là /dev/vda, VirtualBox là /dev/sda
      device = "/dev/vda"; 
    };
  };

  # --- 2. ĐỒ HỌA MÁY ẢO (Dùng Virtio thay vì i965) ---
  # Virtio là driver chuẩn giúp máy ảo có hiệu suất đồ họa tốt nhất
  services.xserver.videoDrivers = [ "virtio" ];

  # --- 3. DỊCH VỤ HỖ TRỢ MÁY ẢO (GUEST AGENTS) ---
  services.qemuGuest.enable = true;      # Hỗ trợ tắt máy/nút bấm từ host
  services.spice-vdagentd.enable = true; # Quan trọng: Giúp Copy/Paste giữa máy thật và máy ảo
  
  # --- 4. TỐI ƯU HÓA (XÓA BỎ CÁC THỨ KHÔNG CẦN THIẾT) ---
  # Máy ảo không có Pin thật nên tắt hoàn toàn TLP
  services.tlp.enable = false;
  powerManagement.cpuFreqGovernor = "performance";

  # Mount folder chia sẻ từ Host (nếu cần)
  # fileSystems."/mnt/shared" = {
  #   device = "shared_folder_name";
  #   fsType = "9p";
  #   options = [ "trans=virtio" "version=9p2000.L" ];
  # };
}
