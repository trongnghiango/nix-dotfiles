#!/bin/bash

# ==============================================================================
# Script: Combine Source Code to Markdown
# Tính năng: 
#   1. Hỗ trợ nhiều định dạng tham số (-p /path, -p=/path, --path /path, --path=/path)
#   2. Loại bỏ file media, binary, assets
#   3. Tự động lấy extension file làm ngôn ngữ cho code block (```ext)
#   4. Loại bỏ dòng trống trong code
#   5. Tùy chọn quét cả thư mục ẩn (-a)
# ==============================================================================

# Giá trị mặc định
PATH_DIR="."
OUTPUT_FILE="output.md"
IGNORE_PATTERNS=()
SCAN_HIDDEN=false

# Danh sách các đuôi file media/binary cần loại bỏ
EXCLUDED_EXTS="png|jpg|jpeg|gif|svg|ico|webp|mp4|mov|wmv|avi|mp3|wav|flac|pdf|zip|tar|gz|7z|rar|exe|bin|pyc|ttf|woff|woff2|eot|otf|dll|so|dylib|class"

show_help() {
    echo "Sử dụng: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -p, --path [DIR]       Thư mục cần quét (VD: -p src, --path=src)"
    echo "  -o, --out [FILE]       File kết quả (Mặc định: output.md)"
    echo "  -i, --ignore [PAT]     Regex bỏ qua (VD: -i 'node_modules|vendor')"
    echo "  -a, --all              Quét cả file/thư mục ẩn (.git, .env...)"
    echo "  -h, --help             Hiển thị trợ giúp"
    exit 0
}

# 1. Xử lý tham số (Hỗ trợ cả 4 định dạng như yêu cầu)
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--path)
            if [[ -n "$2" && "$2" != -* ]]; then PATH_DIR="$2"; shift 2; else echo "Lỗi: Thiếu đường dẫn"; exit 1; fi ;;
        -p=*|--path=*)
            PATH_DIR="${1#*=}"; shift ;;
        -o|--out)
            if [[ -n "$2" && "$2" != -* ]]; then OUTPUT_FILE="$2"; shift 2; else echo "Lỗi: Thiếu tên file out"; exit 1; fi ;;
        -o=*|--out=*)
            OUTPUT_FILE="${1#*=}"; shift ;;
        -i|--ignore)
            if [[ -n "$2" && "$2" != -* ]]; then IGNORE_PATTERNS+=("$2"); shift 2; else echo "Lỗi: Thiếu pattern"; exit 1; fi ;;
        -i=*|--ignore=*)
            IGNORE_PATTERNS+=("${1#*=}"); shift ;;
        -a|--all)
            SCAN_HIDDEN=true; shift ;;
        -h|--help) show_help ;;
        *) echo "Lỗi: Không rõ tham số $1" >&2; exit 1 ;;
    esac
done

# Kiểm tra thư mục hợp lệ
if [ ! -d "$PATH_DIR" ]; then
    echo "Lỗi: Thư mục '$PATH_DIR' không tồn tại." >&2
    exit 1
fi

# Reset file output
> "$OUTPUT_FILE"

# Hàm kiểm tra file text và loại bỏ asset/binary
is_valid_source_file() {
    local file="$1"
    local filename=$(basename -- "$file")
    local extension="${filename##*.}"
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

    # Loại bỏ theo extension media
    if [[ "$extension" =~ ^($EXCLUDED_EXTS)$ ]]; then return 1; fi

    # Kiểm tra MIME type (phải là text hoặc json/xml/javascript)
    local mime_type=$(file --mime-type -b "$file")
    if [[ ! "$mime_type" =~ ^text/ ]] && \
       [[ ! "$mime_type" =~ "json" ]] && \
       [[ ! "$mime_type" =~ "javascript" ]] && \
       [[ ! "$mime_type" =~ "typescript" ]] && \
       [[ ! "$mime_type" == "inode/x-empty" ]]; then
        return 1
    fi

    # Kiểm tra Binary thực tế (NULL bytes)
    if grep -Iq . "$file" 2>/dev/null; then return 0; else return 1; fi
}

# Kiểm tra pattern người dùng muốn bỏ qua
should_ignore() {
    local file="$1"
    if [[ "$file" == *"$OUTPUT_FILE" ]]; then return 0; fi
    for pattern in "${IGNORE_PATTERNS[@]}"; do
        if [[ "$file" =~ $pattern ]]; then return 0; fi
    done
    return 1
}

echo "Đang quét: $PATH_DIR"
echo "Kết quả sẽ lưu vào: $OUTPUT_FILE"
echo "------------------------------------------"

# Xây dựng lệnh find
FIND_CMD="find \"$PATH_DIR\" -type f"
if [ "$SCAN_HIDDEN" = false ]; then
    FIND_CMD="$FIND_CMD -not -path '*/.*'"
fi

# Thực thi quét
eval $FIND_CMD -print0 | while IFS= read -r -d '' file; do
    
    # Bỏ qua nếu khớp pattern ignore
    if should_ignore "$file"; then continue; fi
    
    # Bỏ qua nếu là file binary/media
    if ! is_valid_source_file "$file"; then continue; fi

    echo "Đang xử lý: $file"

    # --- LOGIC CẮT EXTENSION ---
    filename=$(basename -- "$file")
    if [[ "$filename" == *.* ]]; then
        # Lấy phần sau dấu chấm cuối cùng
        ext="${filename##*.}"
    else
        # Nếu không có dấu chấm (như Dockerfile, Makefile), để trống
        ext=""
    fi

    # Ghi tiêu đề file vào Markdown
    echo "## File: $file" >> "$OUTPUT_FILE"
    
    # Mở block code với extension tương ứng (VD: ```py)
    echo '```'"$ext" >> "$OUTPUT_FILE"
    
    # Đọc nội dung file, dùng sed xóa các dòng chỉ chứa khoảng trắng hoặc rỗng
    sed '/^[[:space:]]*$/d' "$file" >> "$OUTPUT_FILE"
    
    # Đóng block code
    echo -e "\n\`\`\`\n" >> "$OUTPUT_FILE"

done

echo "------------------------------------------"
echo "HOÀN TẤT! File đã được gộp tại: $OUTPUT_FILE"
