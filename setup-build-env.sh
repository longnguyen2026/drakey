cat << 'EOF' > /home/long/vdkey/setup-build-env.sh
#!/usr/bin/env bash
set -e

echo "=== Đang cài đặt môi trường biên dịch cho vdkey (Fcitx5 + Rust) ==="

# 1. Cập nhật danh sách gói
echo "[1/4] Đang cập nhật danh sách gói hệ thống..."
sudo apt update -y

# 2. Cài đặt các công cụ biên dịch C++, CMake, Ninja
echo "[2/4] Đang cài đặt công cụ biên dịch cơ bản..."
sudo apt install -y \
    build-essential \
    cmake \
    ninja-build \
    extra-cmake-modules \
    pkg-config \
    gettext \
    curl \
    git

# 3. Cài đặt thư viện phát triển Fcitx5
echo "[3/4] Đang cài đặt các thư viện Fcitx5 dev..."
sudo apt install -y \
    libfcitx5core-dev \
    libfcitx5config-dev \
    libfcitx5utils-dev \
    fcitx5 \
    fcitx5-frontend-gtk2 \
    fcitx5-frontend-gtk3 \
    fcitx5-frontend-qt5 \
    fcitx5-module-x11

# 4. Cài đặt Cargo và Rustc để biên dịch Bamboo Engine
echo "[4/4] Đang cài đặt Rust & Cargo..."
sudo apt install -y cargo rustc

echo "=== Cài đặt hoàn tất! Máy đã sẵn sàng để biên dịch vdkey ==="
EOF

chmod +x /home/long/vdkey/setup-build-env.sh
