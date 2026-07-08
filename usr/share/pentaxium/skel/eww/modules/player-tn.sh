#!/bin/bash

# Đường dẫn lưu ảnh cho Eww
TARGET_PATH="$HOME/.config/eww/misc/media-art.png"

# Tạo thư mục nếu chưa có
mkdir -p "$(dirname "$TARGET_PATH")"

# 1. Thử lấy artUrl từ playerctl
art_url=$(playerctl metadata --format "{{ mpris:artUrl }}" 2>/dev/null)

# Nếu artUrl có sẵn và là file cục bộ hoặc URL hợp lệ
if [ -n "$art_url" ]; then
    # Nếu playerctl trả về đường dẫn dạng file://, ta copy thẳng luôn
    if [[ "$art_url" == "file://"* ]]; then
        cp "${art_url#file://}" "$TARGET_PATH"
        echo "$TARGET_PATH"
        exit 0
    else
        # Nếu là URL mạng, tải về bằng curl
        if curl -s "$art_url" -o "$TARGET_PATH"; then
            echo "$TARGET_PATH"
            exit 0
        fi
    fi
fi

# 2. Nếu artUrl rỗng, trích xuất thủ công từ xesam:url
media_url=$(playerctl metadata --format "{{ xesam:url }}" 2>/dev/null)

if [ -n "$media_url" ]; then
    if [[ "$media_url" == *"youtube.com"* || "$media_url" == *"youtu.be"* ]]; then
        video_id=""
        
        if [[ "$media_url" == *"v="* ]]; then
            video_id=$(echo "$media_url" | sed -n 's/.*v=\([^&]*\).*/\1/p')
        elif [[ "$media_url" == *"youtu.be/"* ]]; then
            video_id=$(echo "$media_url" | sed -n 's/.*youtu.be\/\([^?&]*\).*/\1/p')
        fi

        if [ -n "$video_id" ]; then
            img_url="https://img.youtube.com/vi/$video_id/maxresdefault.jpg"
            
            # Tải ảnh thumbnail về đường dẫn chỉ định
            curl -s "$img_url" -o "$TARGET_PATH"
            
            # Kiểm tra nếu ảnh maxresdefault lỗi (vài video cũ không có), dùng bản hqdefault thay thế
            if [ ! -s "$TARGET_PATH" ] || [ "$(identify -format "%w" "$TARGET_PATH" 2>/dev/null)" == "120" ]; then
                curl -s "https://img.youtube.com/vi/$video_id/hqdefault.jpg" -o "$TARGET_PATH"
            fi
            
            echo "$TARGET_PATH"
            exit 0
        fi
    fi
fi

# Nếu thất bại hoàn toàn, vẫn trả về path để tránh lỗi widget (hoặc bạn có thể đổi thành path ảnh mặc định)
echo "$TARGET_PATH"
exit 1