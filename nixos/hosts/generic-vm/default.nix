{
  config,
  pkgs,
  hostName,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix # File này sẽ được gen khi bạn cài máy ảo
    ./optimize-hw.nix # Tối ưu dành riêng cho môi trường ảo hóa
    ../../modules/system/core.nix
    ../../modules/system/shell.nix
    ../../modules/system/user.nix
    ../../modules/system/desktop.nix
    ../../modules/system/audio.nix
  ];

  networking.hostName = hostName;

  # State version theo đúng bản flake
  system.stateVersion = "25.11";
}
