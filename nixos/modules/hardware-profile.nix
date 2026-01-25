{ lib, config, ... }:

with lib;

{
  options.hardware.profile = {
    hostType = mkOption {
      type = types.enum [ "laptop" "workstation" "vm" ];
      description = "Physical type of host";
    };

    cpu = mkOption {
      type = types.enum [ "intel" "amd" "xeon" ];
    };

    gpu = mkOption {
      type = types.enum [ "intel" "virtio" "nvidia-legacy" "none" ];
    };

    opengl = mkOption {
      type = types.bool;
      default = true;
    };

    isVirtual = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = { };
}
