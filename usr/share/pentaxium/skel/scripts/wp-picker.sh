#!/usr/bin/env bash

# Đường dẫn đến thư mục hình nền
WALL_DIR="$HOME/.local/share/hyprVix/Wallpapers"

if [ ! -d "$WALL_DIR" ]; then
    notify-send "Wallpaper Picker" "Thư mục hình nền không tồn tại!"
    exit 1
fi

# Dùng find để quét ảnh và tự động định dạng chuẩn Rofi parse: "Tên_File\0icon\x1fĐường_Dẫn"
# Sau đó dùng rofi để bắt kết quả chọn
CHOICE=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -exec basename {} \; | \
    awk -v dir="$WALL_DIR" '{print $0 "\0icon\x1f" dir "/" $0}' | \
    rofi -dmenu \
         -i \
         -show-icons \
         -p "󰸉 Chọn hình nền:" \
         -theme ~/.config/rofi/wallpaper-picker-dark.rasi)

# Nếu người dùng chọn một ảnh và bấm Enter
if [ -n "$CHOICE" ]; then
    # Thực hiện lệnh thay đổi hình nền bằng awww
    # outer, wipe
    awww img "$WALL_DIR/$CHOICE" --transition-type outer --transition-pos center --transition-step 255 --transition-fps 60
    
    cp "$WALL_DIR/$CHOICE" "$HOME/.config/hypr/hyprlock.png"
        
    # Gửi thông báo
    notify-send "Wallpaper" "Đã đổi hình nền thành: $CHOICE" -i "$WALL_DIR/$CHOICE"
fi
