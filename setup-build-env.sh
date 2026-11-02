cat << 'EOF' > /home/long/vdkey/setup-build-env.sh
#!/usr/bin/env bash
set -e

echo "=== Đang cài đặt trọn bộ môi trường biên dịch cho vdkey ==="

# 1. Cập nhật hệ thống
sudo apt update -y

# 2. Công cụ build C++, CMake, Ninja & Git
sudo apt install -y \
    build-essential \
    cmake \
    ninja-build \
    extra-cmake-modules \
    pkg-config \
    gettext \
    curl \
    git

# 3. Thư viện Fcitx5 dev và các gói giao diện
sudo apt install -y \
    libfcitx5core-dev \
    libfcitx5config-dev \
    libfcitx5utils-dev \
    fcitx5 \
    fcitx5-frontend-gtk2 \
    fcitx5-frontend-gtk3 \
    fcitx5-frontend-qt5 \
    fcitx5-module-x11

# 4. Thư viện X11, XTest & D-Bus (Bắt buộc cho engine gõ phím)
sudo apt install -y \
    libx11-dev \
    libxtst-dev \
    libdbus-1-dev \
    libglib2.0-dev

# 5. Rust & Cargo cho lõi xử lý tiếng Việt Bamboo
sudo apt install -y cargo rustc

echo "=== ĐÃ CÀI ĐỦ 100% THƯ VIỆN CẦN THIẾT CHO VDKEY ==="
EOF

chmod +x /home/long/vdkey/setup-build-env.sh
cd /home/long/vdkey
git commit -am "fix: add missing X11, XTest and D-Bus build dependencies to setup script"
git push origin main
