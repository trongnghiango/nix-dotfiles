{ config, pkgs, dotfiles, gpuType, ... }:

{
  imports = [
    ../modules/home/theme.nix
    # ../modules/home/programs/brave.nix
    ../modules/home/programs/qutebrowser.nix
    ../modules/home/programs/min-browser.nix
    ../modules/home/programs/appimages.nix # Gồm cả Obsidian
  ];

  # 1. Ứng dụng GUI (End-user)
  home.packages = with pkgs; [
    dbeaver-bin nsxiv zathura mpv yt-dlp calcurse pavucontrol
    picom xcompmgr dunst unclutter rofi trayer xwallpaper arandr
    networkmanagerapplet yad libnotify clipmenu xclip maim slop
    xdotool brightnessctl libva-utils
  ];

  # 2. Bộ gõ tiếng Việt (Fcitx5)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-bamboo fcitx5-gtk qt6Packages.fcitx5-unikey ];
  };

  # 3. Symlinks cho môi trường đồ họa
  home.file = {
    # -- Media & Apps --
    ".config/mpd".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/mpd";
    ".config/ncmpcpp".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/ncmpcpp";
    ".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/media/.config/mpv";
    ".config/nsxiv".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nsxiv/.config/nsxiv";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/rofi/.config/rofi";
    ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/dunst/.config/dunst";

    # -- X11 & Scripts --
    ".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xinitrc";
    ".xprofile".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11/xprofile";
    ".config/x11".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/x11/.config/x11";
    ".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/scripts/.local/bin";
  };

  # 4. Launcher (Rofi/Dmenu)
  xdg.desktopEntries.lf = {
    name = "LF File Manager";
    exec = "st -e lfub %u";
    icon = "system-file-manager";
    terminal = false;
    categories = [ "System" "FileManager" ];
  };

  home.sessionVariables = {
    BROWSER = "qutebrowser";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}

