{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Runtimes ---
    nodejs_22
    python3
    go
    zig
    gcc
    gnumake
    sqlite

    # --- LSP Servers ---
    lua-language-server
    gopls
    zls
    nodePackages.typescript-language-server
    rust-analyzer
    pyright
    vscode-langservers-extracted
    bash-language-server
    nil

    # --- Formatters & Linters ---
    stylua
    gotools
    nodePackages.prettier
    nodePackages.eslint_d
    shellcheck
    shfmt
    ruff
    nixfmt-rfc-style

    # --- Tools ---
    lazygit
    jq
    socat
    bc
    tectonic
  ];

  # Path cho các công cụ biên dịch
  home.sessionPath = [
    "$HOME/go/bin"
    "$HOME/.cargo/bin"
  ];
}
