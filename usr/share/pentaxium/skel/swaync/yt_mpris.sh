#!/bin/bash

# Thư mục và file tạm
THUMB_FILE="/tmp/swaync_thumb.jpg"
DEFAULT_ICON="/usr/share/icons/hicolor/scalable/apps/firefox.svg"

# Tạo sẵn ảnh mặc định nếu file chưa tồn tại để tránh lỗi SwayNC không tìm thấy file
if [ ! -f "$THUMB_FILE" ]; then
    cp "$DEFAULT_ICON" "$THUMB_FILE" 2>/dev/null || touch "$THUMB_FILE"
fi

# Kiểm tra xem Firefox có đang chạy nhạc không
if ! playerctl -p firefox status >/dev/null 2>&1; then
    # Nếu không phát nhạc, ẩn widget một cách an toàn
    echo "{\"text\": \"\", \"alt\": \"\", \"tooltip\": \"\", \"class\": \"hidden\", \"hidden\": true}"
    exit 0
fi

# Lấy Metadata
TITLE=$(playerctl -p firefox metadata xesam:title 2>/dev/null | sed 's/"/\\"/g')
ARTIST=$(playerctl -p firefox metadata xesam:artist 2>/dev/null | sed 's/"/\\"/g')
URL=$(playerctl -p firefox metadata xesam:url 2>/dev/null)

if [[ "$URL" == *"youtube.com"* || "$URL" == *"youtu.be"* ]]; then
    VIDEO_ID=$(echo "$URL" | sed -n 's/.*v=\([^&]*\).*/\1/p')
    if [ -n "$VIDEO_ID" ]; then
        # Tải ảnh về nếu chưa có sẵn
        if [ ! -f "/tmp/yt_${VIDEO_ID}.jpg" ]; then
            curl -s "https://img.youtube.com/vi/${VIDEO_ID}/hqdefault.jpg" -o "/tmp/yt_${VIDEO_ID}.jpg"
            cp "/tmp/yt_${VIDEO_ID}.jpg" "$THUMB_FILE"
        fi
    fi
fi

# Trả về JSON chứa cả thông tin text lẫn đường dẫn ảnh (dùng key "image")
echo "{\"text\": \"$TITLE\", \"tooltip\": \"$ARTIST\", \"image\": \"$THUMB_FILE\", \"class\": \"playing\"}"
