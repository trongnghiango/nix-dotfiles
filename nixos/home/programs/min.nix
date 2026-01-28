{ pkgs, gpuType, ... }:

let
  # Tối ưu cờ chạy cho Electron (Min Browser)
  # Máy ảo (virtio) thì tắt GPU, máy thật (intel-legacy) thì bật tăng tốc phần cứng
  minFlags = if gpuType == "virtio" 
             then "--disable-gpu" 
             else "--ignore-gpu-blocklist --enable-gpu-rasterization";
in
{
  home.packages = with pkgs; [
    min
  ];

  # Tạo file .desktop tùy chỉnh để nạp các cờ tối ưu ngay từ Rofi/Dmenu
  xdg.desktopEntries."min" = {
    name = "Min";
    genericName = "Web Browser";
    # Gọi binary của min kèm theo các cờ tối ưu
    exec = "min ${minFlags} %U";
    icon = "min";
    terminal = false;
    categories = [ "Network" "WebBrowser" ];
    mimeType = [ "text/html" "text/xml" "application/xhtml+xml" "x-scheme-handler/http" "x-scheme-handler/https" ];
  };
}
