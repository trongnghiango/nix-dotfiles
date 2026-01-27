{
  description = "NixOS Pro Configuration - Multi-host System";

  inputs = {
    # NixOS 25.11 (Bản mới nhất tại thời điểm hiện tại)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager đồng bộ version 25.11
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # --- Suckless Sources (Git Prod) ---
    dwm-src = { url = "github:trongnghiango/nix-suckless?dir=dwm"; flake = false; };
    st-src = { url = "github:trongnghiango/nix-suckless?dir=st"; flake = false; };
    dmenu-src = { url = "github:trongnghiango/nix-suckless?dir=dmenu"; flake = false; };
    dwmblocks-src = { url = "github:trongnghiango/nix-suckless?dir=dwmblocks"; flake = false; };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # 1. BIẾN TOÀN CỤC (Để đổi 1 nơi là cả hệ thống đổi theo)
      user = "ka";
      dotfilesPath = "/home/${user}/.dotfiles";

      # 2. HÀM TẠO HOST (HÀM THẦN THÁNH ĐỂ TÁCH BIỆT PHẦN CỨNG)
      # Giúp tạo máy mới chỉ trong 1 dòng code
      mkSystem = { hostName, deviceType, bootMode, uiScale, gpuType}: 
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          
          # Truyền biến vào các file modules/*.nix (NixOS level)
          specialArgs = { 
            inherit inputs hostName user gpuType; 
            isLaptop = (deviceType == "laptop");
            isEfi = (bootMode == "efi");
            scale = uiScale;
          };

          modules = [
            # Nạp cấu hình riêng của từng Host (Ví dụ: hosts/thinkbox/default.nix)
            ./hosts/${hostName}/default.nix

            # Cấu hình Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.${user} = import ./home/home.nix;

                # Truyền biến vào các file home/*.nix (Home Manager level)
                # Giúp theme.nix tự động co giãn font/cursor theo máy
                extraSpecialArgs = {
                  inherit inputs user gpuType;
                  dotfiles = dotfilesPath;
                  isLaptop = (deviceType == "laptop");
                  scale = uiScale;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        # =============================================================
        # 3. DANH SÁCH CÁC MÁY (HOSTS)
        # Cú pháp: mkSystem { hostName, deviceType, bootMode, uiScale }
        # =============================================================

        # ThinkPad X230: Laptop, Boot EFI, Màn hình nhỏ (Scale 1.0)
        thinkbox = mkSystem {
          hostName = "thinkbox";
          deviceType = "laptop";
          bootMode = "efi";
          uiScale = 1.0;
          gpuType = "intel-legacy"; 
        };

        # Máy ảo Z600 hoặc PC cũ: Desktop, Boot BIOS, Màn hình nhỏ (Scale 1.0)
        # Chú ý: Cần chỉnh optimize-hw.nix để cài Grub vào đúng ổ đĩa.
        vm-z600 = mkSystem {
          hostName = "vm-z600";
          deviceType = "desktop";
          bootMode = "bios";
          uiScale = 1.0;
          gpuType = "virtio"; # <-- Đánh dấu cho Máy ảo
        };

        # Host mới cho máy ảo
        vm-x230 = mkSystem {
          hostName = "vm-x230";
          deviceType = "desktop"; # Chọn desktop để tắt TLP pin
          bootMode = "efi";       # Thường máy ảo hiện đại chọn EFI (OVMF)
          uiScale = 1.5;          # Máy ảo cửa sổ nhỏ nên để scale 1.0
          gpuType = "virtio"; # <-- Đánh dấu cho Máy ảo
        };

        # Demo máy 4K trong tương lai (Ví dụ Workstation)
        # workstation = mkSystem {
        #   hostName = "workstation";
        #   deviceType = "desktop";
        #   bootMode = "efi";
        #   uiScale = 1.5; # Chữ tự động to ra 1.5 lần
        # };
      };
    };
}
