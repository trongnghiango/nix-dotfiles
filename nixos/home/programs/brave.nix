{ pkgs, gpuType, ... }:

let
  # --- LOGIC TỐI ƯU THEO PHẦN CỨNG ---
  braveArgs = 
    let
      base = [
        "--password-store=basic"
        "--process-per-site"
        "--incognito" # Ví dụ: Luôn mở ẩn danh cho máu
      ];
      
      intelLegacy = [
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--use-gl=egl"
      ];

      virtio = [
        "--disable-gpu"
      ];
    in
    base ++ (
      if gpuType == "intel-legacy" then intelLegacy
      else if gpuType == "virtio" then virtio
      else []
    );
in
{
  programs.brave = {
    enable = true;
    commandLineArgs = braveArgs;
    
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "omkfmpieigblcllmkgbflkikinpkodjg"; } # enhanced-h264ify
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    ];
  };
}


    # commandLineArgs = [
    #   "--enable-features=VaapiVideoDecodeLinuxGL" # VA-API Video Decode
    #   "--use-gl=egl"
    #   "--ignore-gpu-blocklist" # Ép chạy GPU cũ
    #   "--enable-gpu-rasterization"
    #   "--enable-zero-copy"
    #   "--process-per-site" # Tiết kiệm RAM
    # ];

