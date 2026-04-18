# ⛩️ Ka's Hybrid Dotfiles

![NixOS](https://img.shields.io/badge/NixOS-Blue?style=for-the-badge&logo=nixos&logoColor=white)
![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Void Linux](https://img.shields.io/badge/Void_Linux-474032?style=for-the-badge&logo=void-linux&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)

A minimalist, highly optimized, and **OS-Agnostic** dotfiles configuration. Built around the Suckless philosophy (DWM, st) but modernized with Lua-based Neovim, Wayland-ready audio (Pipewire), and intelligent shell scripts.

## ✨ Key Features

- **Hybrid Architecture:** Works flawlessly on **NixOS** (declarative via Flakes/Home Manager) AND traditional distros like **Arch/Void Linux** (imperative via GNU Stow).
- **100% XDG Compliant:** Keeps your `$HOME` directory completely clean. No more dotfile clutter.
- **Dynamic Environment:** Custom `shortcuts` script automatically generates bookmark bindings for `zsh`, `lf`, `nvim`, and `qutebrowser` based on your `$HOME` path.
- **Hardware Optimized:** Includes specific tweaks for older hardware (Intel HD4000 / ThinkPad X230) and Virtual Machines (Virtio).

## 🧰 The Arsenal

| Category | Application | Description |
| :--- | :--- | :--- |
| **Window Manager** | [DWM](https://dwm.suckless.org/) | Custom build, patched via Nix overlays or manual make |
| **Terminal** | [st](https://st.suckless.org/) | Simple terminal with custom color palette |
| **Shell** | Zsh + Tmux | Fast syntax highlighting, vi-mode, zoxide |
| **Editor** | Neovim | Custom Lua config (Lazy.nvim, Blink.cmp, Snacks.nvim) |
| **File Manager** | [lf](https://github.com/gokcehan/lf) | Vi-keybindings with `ueberzugpp` image previews |
| **Launcher** | dmenu / rofi | Fast application and script execution |
| **Status Bar** | dwmblocks | Modular, signal-based status bar |
| **Media** | mpv, nsxiv, zathura | Minimalist media, image, and document viewers |

---

## 🚀 Installation Guide

### 1. Preparation
Clone this repository to your home directory:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Option A: For Arch Linux / Void Linux (via GNU Stow)
Ensure you have the required dependencies installed (`stow`, `git`, `zsh`, `neovim`, etc.).

```bash
# 1. Symlink configurations using GNU Stow
stow -t ~ zsh nvim lf tmux x11 rofi dunst

# 2. Symlink personal scripts
stow -t ~ scripts

# 3. Generate dynamic shortcuts (CRITICAL STEP)
# This adapts all configurations to your specific username
~/.local/bin/shortcuts
```

### 3. Option B: For NixOS (via Flakes)
NixOS users do not need GNU Stow. The configuration is handled declaratively.

```bash
# Navigate to the nixos directory
cd ~/.dotfiles/nixos

# Apply the configuration (Replace 'thinkbox' with your target host)
sudo nixos-rebuild switch --flake .#thinkbox
```

---

## 🛠️ Notable Custom Scripts

This repository contains several powerful shell scripts located in `scripts/.local/bin/`:

- **`gm` (Git Manager):** A multi-account Git management tool. Easily initialize, clone, and sync repositories into organized `~/Repos/Server/User` structures without messing up global SSH keys.
- **`shortcuts`:** Reads your bookmarked directories (`bm-dirs`) and files (`bm-files`) and automatically translates them into aliases and keybindings for `zsh`, `lf`, and `nvim`.
- **`sysact`:** An OS-aware power menu (dmenu-based) that safely handles DWM exiting, system suspending (Systemd/Runit/Elogind), and locking.
- **`combine`:** A developer tool to automatically scan, filter, and combine source code files into a single Markdown file for AI context feeding.

## 🎨 Aesthetic

- **Theme:** Custom `Yukinord-Mocha` (Nord + Catppuccin Mocha blend).
- **Fonts:** JetBrainsMono Nerd Font (Terminal), Inter (UI), BlexMono (DWM Bar).

> *"UNIX is very simple, it just needs a genius to understand its simplicity."* - Dennis Ritchie
