{ config, pkgs, ... }:

{
  # --- 1. Drivers Đồ họa (Đặc thù cho Intel HD 4000) ---
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # i965 chuẩn cho Ivy Bridge
      libvdpau-va-gl
      vaapiIntel
    ];
  };

  # --- 2. Biến môi trường đồ họa ---
  environment.sessionVariables = { 
    LIBVA_DRIVER_NAME = "i965"; 
  };

  # --- 3. Cấu hình Xserver cho chip cũ ---
  services.xserver.videoDrivers = [ "modesetting" ];
  # services.xserver.videoDrivers = [ "virtio" ]; # virt-machine

  # --- 4. Tối ưu Kernel cho phần cứng ThinkPad X230 ---
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [ 
    "i915.enable_fbc=1" 
    "i915.enable_psr=0" # Fix nháy màn hình X230
    "intel_iommu=on"
  ];

  # --- 5. Hỗ trợ CPU Intel ---
  hardware.cpu.intel.updateMicrocode = true;
  
  # Quản lý điện năng cho Laptop cũ
  services.tlp.enable = true; 
}
