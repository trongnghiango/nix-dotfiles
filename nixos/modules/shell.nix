{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  environment.etc."zshenv".text = ''
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"

    if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
      export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
    fi

    # CLEAN CODE: Đặt PATH hệ thống lên trước để tránh xung đột binary cũ
    export PATH="$PATH:$HOME/.dotfiles/bin/.local/bin:$HOME/.dotfiles/user-bin/.local/bin:$HOME/.local/bin"
  '';

  # Các tool CLI hiện đại (cài cho toàn hệ thống để user nào cũng dùng được)
  environment.systemPackages = with pkgs; [
    fzf eza bat zoxide fnm
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
