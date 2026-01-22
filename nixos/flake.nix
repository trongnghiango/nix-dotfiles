{
  description = "NixOS Configuration for Thinkbox";

  inputs = {
    # Nguồn gói phần mềm chính của NixOS (bản unstable mới nhất)
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager để quản lý file cấu hình user (dotfiles)
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # =================================================================
    # KHAI BÁO SOURCE CODE CỤC BỘ (LOCAL SOURCES)
    # =================================================================
    # Cú pháp "path:..." bảo Nix lấy code từ thư mục máy tính của bạn.
    # "flake = false" nghĩa là: đây chỉ là thư mục chứa code C thường,
    # không phải là một Nix Flake khác.

    # on git -  for prod
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

    # on local - using de test
    # dwm-src = {
    #   url = "path:/home/ka/.local/src/dwm";
    #   flake = false;
    # };
    #
    # st-src = {
    #   url = "path:/home/ka/.local/src/st";
    #   flake = false;
    # };
    #
    # dmenu-src = {
    #   url = "path:/home/ka/.local/src/dmenu";
    #   flake = false;
    # };
    #
    # dwmblocks-src = {
    #   url = "path:/home/ka/.local/src/dwmblocks";
    #   flake = false;
    # };
  };

  # Thêm biến @inputs vào đây để lấy các nguồn đã khai báo ở trên
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        thinkbox = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          # =============================================================
          # QUAN TRỌNG: Truyền biến 'inputs' vào tất cả các modules con
          # =============================================================
          # Dòng này giúp các file như modules/desktop.nix có thể
          # truy cập được dwm-src, st-src...
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/thinkbox/default.nix # File cấu hình chính của máy

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.ka = import ./home/home.nix;

              # Truyền đường dẫn dotfiles vào Home Manager
              home-manager.extraSpecialArgs = {
                dotfiles = "/home/ka/.dotfiles";
              };

              # Tự động đổi tên file config cũ thành .backup nếu bị trùng
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
      };
    };
}
