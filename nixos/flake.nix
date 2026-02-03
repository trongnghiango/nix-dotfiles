# flake.nix
{
  description = "NixOS Pro Configuration - Multi-host & Multi-profile";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Suckless
    dwm-src = {
      url = "github:trongnghiango/nix-suckless?dir=dwm";
      flake = false;
    };
    st-src = {
      url = "github:trongnghiango/nix-suckless?dir=st";
      flake = false;
    };
    dmenu-src = {
      url = "github:trongnghiango/nix-suckless?dir=dmenu";
      flake = false;
    };
    dwmblocks-src = {
      url = "github:trongnghiango/nix-suckless?dir=dwmblocks";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      user = "ka";
      dotfiles = "/home/${user}/.dotfiles";

      # HÀM MK-SYSTEM: Tự động nạp cấu hình hệ thống VÀ Profile của user
      mkSystem =
        {
          hostName,
          deviceType,
          bootMode,
          uiScale,
          gpuType,
          display,
          profiles ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              hostName
              user
              gpuType
              display
              ;
            isLaptop = (deviceType == "laptop");
            isEfi = (bootMode == "efi");
            scale = uiScale;
          };
          modules = [
            ./hosts/${hostName}/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit
                    inputs
                    user
                    dotfiles
                    gpuType
                    display
                    ;
                  scale = uiScale;
                };
                users.${user} = {
                  # Nạp profile chung và các profile tùy chọn
                  imports = [ ./profiles/common.nix ] ++ profiles;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        # MÁY THẬT X230: Vừa làm việc (Workstation), vừa lập trình (Developer)
        thinkbox = mkSystem {
          hostName = "thinkbox";
          deviceType = "laptop";
          bootMode = "efi";
          uiScale = 1.0;
          gpuType = "intel-legacy";
          display = {
            width = 1360;
            height = 768;
            rate = 60;
            barHeight = 24;
            gap = 8;
          };
          profiles = [
            ./profiles/workstation.nix
            ./profiles/developer.nix
          ];
        };

        # MÁY ẢO VẠN NĂNG: Chỉ nạp Workstation để test UI
        generic-vm = mkSystem {
          hostName = "generic-vm";
          deviceType = "desktop";
          bootMode = "efi";
          # bootMode = "bios";
          uiScale = 1.0;
          gpuType = "virtio";
          display = {
            width = 1360;
            height = 768;
            rate = 60;
            barHeight = 25;
            gap = 10;
          };
          profiles = [ ./profiles/workstation.nix ];
        };
      };
    };
}
