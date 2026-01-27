{ config, pkgs, hostName, ... }:

{
  imports = [
    ./hardware-configuration.nix # File này sẽ được gen khi bạn cài máy ảo
    ./optimize-hw.nix            # Tối ưu dành riêng cho môi trường ảo hóa
    ../../modules/core.nix
    ../../modules/shell.nix
    ../../modules/user.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
  ];

  networking.hostName = hostName;

  # State version theo đúng bản flake
  system.stateVersion = "25.11";
}

