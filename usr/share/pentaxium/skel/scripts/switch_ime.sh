#!/usr/bin/env bash

# 1. Kiểm tra bộ gõ hiện tại của Fcitx5 để làm tiêu đề (Prompt) cho thanh Search bar
current_im=$(fcitx5-remote -n)
if [ "$current_im" = "unikey" ]; then
    status_text="Bộ gõ: Tiếng Việt"
    theme_icon="VI"
else
    status_text="Bộ gõ: English"
    theme_icon="EN"
fi

# 2. Danh sách hiển thị rút gọn dùng ký hiệu viết tắt chữ
options="EN  English\nVI  Unikey"

# 3. Gọi Rofi với các tùy biến theme động
chosen=$(echo -e "$options" | rofi \
    -dmenu \
    -i \
    -theme ~/.config/rofi/im-switch.rasi \
    -p "$status_text" \
    -theme-str "textbox-prompt-colon { str: \"$theme_icon\"; }")

# 4. Thực hiện chuyển đổi ngôn ngữ dựa trên lựa chọn
case "$chosen" in
    *English)
        fcitx5-remote -s keyboard-us
        ;;
    *Unikey)
        fcitx5-remote -s unikey
        ;;
esac
