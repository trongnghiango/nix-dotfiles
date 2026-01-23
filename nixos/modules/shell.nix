{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Chỉ cần trỏ đúng 1 file profile là xong!
  environment.etc."zshenv".text = ''
    # Thiết lập biến môi trường cơ bản để tìm được file config
    export XDG_CONFIG_HOME="$HOME/.config"

    #
    export PATH="$HOME/.dotfiles/bin/.local/bin:$HOME/.dotfiles/user-bin/.local/bin:$HOME/.local/bin:$PATH"
    
    # Load Profile từ Dotfiles (Nơi chứa mọi logic: env, alias, startx)
    if [[ -f "$XDG_CONFIG_HOME/shell/profile" ]]; then
      source "$XDG_CONFIG_HOME/shell/profile"
    fi
    
    # Zsh Config location
    if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
      export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
    fi
  '';

  environment.systemPackages = with pkgs; [
    fzf eza bat zoxide fnm
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
