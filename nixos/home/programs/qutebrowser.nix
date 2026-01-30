{
  pkgs,
  gpuType,
  scale,
  ...
}:

let
  # Nhân tỉ lệ cho font giống như đã làm ở theme.nix
  multiply = size: builtins.floor (size * scale);

  # --- DANH SÁCH BỘ LỌC UBLOCK ORIGIN "THẦN THÁNH" ---
  adblockLists = [
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
  ];

  # Palette màu Yukinord của mày
  palette = {
    bg = "#1B212B";
    fg = "#eceff4";
    red = "#bf616a";
    orange = "#d08770";
    yellow = "#ebcb8b";
    green = "#a3be8c";
    blue = "#81a1c1";
    purple = "#b48ead";
    cyan = "#88c0d0";
    statusbar = "#2B3442";
    selection = "#5e81ac";
  };
in
{
  programs.qutebrowser = {
    enable = true;

    # CHIÊU THỨC "BƠM THUỐC": Ép qutebrowser phải nhận thư viện adblock và tldextract
    package = pkgs.qutebrowser.override {
      python3 = pkgs.python3.withPackages (
        ps: with ps; [
          adblock
          tldextract
          pyyaml
          jinja2
          pygments
        ]
      );
    };

    # --- TỐI ƯU CHO PHẦN CỨNG X230 / MÁY ẢO ---
    extraConfig = ''
      # Tăng tốc phần cứng dựa trên gpuType
      config.set('qt.args', [
        ${
          if gpuType == "intel-legacy" then
            "'--ignore-gpu-blocklist', '--enable-gpu-rasterization', '--enable-zero-copy'"
          else
            "'--disable-gpu'"
        }
      ])
    '';

    settings = {
      # Chặn quảng cáo (Vũ khí tối thượng cho máy yếu)
      content.blocking.method = "both"; # Dùng cả Brave-style và Host-style

      # ĐƯA DANH SÁCH VÀO ĐÂY (Nix sẽ tự chuyển thành mảng trong config.py)
      "content.blocking.adblock.lists" = adblockLists;

      # Tự động nạp danh sách các trang web chặn quảng cáo
      "content.blocking.hosts.lists" = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
        "https://adaway.org/hosts.txt"
      ];

      # Chặn các script theo dõi làm nặng máy
      content.canvas_reading = false; # Chống fingerprinting
      content.webgl = true; # Giữ cái này để xem video mượt

      # --- GIAO DIỆN & FONT ---
      fonts.default_family = "JetBrainsMono Nerd Font";
      fonts.default_size = "${toString (multiply 11)}pt";

      zoom.default = multiply 100; # Tự động zoom nếu là màn 4K

      # Tắt thanh Tab nếu chỉ mở 1 tab cho sạch (Suckless style)
      tabs.show = "multiple";
      tabs.position = "top";

      # --- BẢNG MÀU YUKINORD ---
      colors = {
        # Background của trang web khi chưa load xong
        webpage.bg = palette.bg;

        # Thanh trạng thái (Statusbar)
        statusbar.normal.bg = palette.statusbar;
        statusbar.normal.fg = palette.fg;
        statusbar.insert.bg = palette.green;
        statusbar.insert.fg = palette.bg;
        statusbar.command.bg = palette.bg;
        statusbar.command.fg = palette.fg;

        # Tab Bar
        tabs.bar.bg = palette.bg;
        tabs.even.bg = palette.bg;
        tabs.even.fg = palette.fg;
        tabs.odd.bg = palette.bg;
        tabs.odd.fg = palette.fg;
        tabs.selected.even.bg = palette.selection;
        tabs.selected.even.fg = palette.fg;
        tabs.selected.odd.bg = palette.selection;
        tabs.selected.odd.fg = palette.fg;

        # Hints (Cái chữ hiện lên để nhấn phím nhảy link)
        # Ép dùng màu Đỏ Yukinord để nổi bật
        hints.bg = palette.red;
        hints.fg = palette.bg;
        hints.match.fg = palette.yellow;

        # Completion menu (Lúc gõ lệnh)
        completion.category.bg = palette.statusbar;
        completion.category.fg = palette.cyan;
        completion.item.selected.bg = palette.selection;
        completion.item.selected.fg = palette.fg;
        completion.match.fg = palette.orange;
      };
    };

    # --- PHÍM TẮT ---
    keyBindings = {
      normal = {
        "M" = "spawn mpv {url}"; # Nhấn Shift + M là mở MPV xem luôn
        "J" = "tab-prev";
        "K" = "tab-next";
        "x" = "tab-close";
        "t" = "set-cmd-text -s :open -t";
      };
    };
  };
}
