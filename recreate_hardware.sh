#!/usr/bin/env bash
# recreate_hardware.sh
BACKUP_DIR="$HOME/nixos-backups"
CONFIG_DIR="$HOME/.dotfiles/nixos"
DATE=$(date +%Y%m%d-%H%M%S)
MY_HOST=vm-x230
HW_FILE="$CONFIG_DIR/hosts/$MY_HOST/hardware-configuration.nix"

echo "=== Tạo lại Hardware Configuration ==="

# 1. Backup file cũ
echo "1. Backup file cũ..."
if [ -f "$HW_FILE" ]; then
  sudo cp "$HW_FILE" "$BACKUP_DIR/hardware-configuration.nix.backup-$DATE"
  echo "   Đã backup: $BACKUP_DIR/hardware-configuration.nix.backup-$DATE"
fi

# 2. Xóa file cũ
echo "2. Xóa file cũ..."
sudo rm -f "$HW_FILE"

# 3. Tạo file mới
echo "3. Tạo hardware configuration mới..."
sudo nixos-generate-config --show-hardware-config >"$HW_FILE"

# 4. Kiểm tra
echo "4. Kiểm tra file mới..."
echo "   Dung lượng: $(du -h "$HW_FILE" | cut -f1)"
echo "   Số dòng: $(wc -l <"$HW_FILE")"

echo "=== Hoàn thành ==="
