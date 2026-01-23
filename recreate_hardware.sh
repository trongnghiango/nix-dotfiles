#!/bin/bash
# recreate_hardware.sh
BACKUP_DIR="$HOME/nixos-backups"
CONFIG_DIR="$HOME/.dotfiles/nixos"
DATE=$(date +%Y%m%d-%H%M%S)

echo "=== Tạo lại Hardware Configuration ==="

# 1. Backup file cũ
echo "1. Backup file cũ..."
if [ -f "$CONFIG_DIR/hardware-configuration.nix" ]; then
  sudo cp "$CONFIG_DIR/hardware-configuration.nix" "$BACKUP_DIR/hardware-configuration.nix.backup-$DATE"
  echo "   Đã backup: $BACKUP_DIR/hardware-configuration.nix.backup-$DATE"
fi

# 2. Xóa file cũ
echo "2. Xóa file cũ..."
sudo rm -f "$CONFIG_DIR/hardware-configuration.nix"

# 3. Tạo file mới
echo "3. Tạo hardware configuration mới..."
sudo nixos-generate-config --show-hardware-config >"$CONFIG_DIR/hardware-configuration.nix"

# 4. Kiểm tra
echo "4. Kiểm tra file mới..."
echo "   Dung lượng: $(du -h "$CONFIG_DIR/hardware-configuration.nix" | cut -f1)"
echo "   Số dòng: $(wc -l <"$CONFIG_DIR/hardware-configuration.nix")"

echo "=== Hoàn thành ==="
