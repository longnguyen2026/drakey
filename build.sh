
#!/usr/bin/env bash
set -Eeuo pipefail

# Drakey Source Preparation
# Tải source Ngó Sen nguyên bản và cài công cụ build.
# Không cài/gỡ bộ gõ, không thay đổi cấu hình Fcitx5.

REPO_URL="https://github.com/ngosen/ngosen.git"
SOURCE_ROOT="${HOME}/drakey-sources"

if [[ $EUID -eq 0 ]]; then
    echo "Không chạy script bằng sudo. Hãy chạy bằng user thường."
    exit 1
fi

if ! command -v apt-get >/dev/null 2>&1; then
    echo "Script này dành cho Ubuntu/Kubuntu/Linux Mint nền Ubuntu."
    exit 1
fi

echo "=== 1. Cài công cụ và thư viện phát triển ==="
sudo apt-get update

sudo apt-get install -y \
    git ca-certificates curl \
    build-essential cmake ninja-build pkg-config \
    extra-cmake-modules gettext \
    fcitx5 fcitx5-modules-dev \
    libfcitx5core-dev libfcitx5config-dev libfcitx5utils-dev \
    libxcb-xinput-dev libxcb-xtest0-dev \
    python3 python3-dev python3-pip python3-venv \
    python3-pyqt6 python3-pyqt6.qtsvg \
    cargo rustc

echo
echo "=== 2. Kiểm tra phiên bản Rust ==="
if ! command -v rustc >/dev/null 2>&1 ||
   ! rustc --version | grep -Eq 'rustc 1\.(8[8-9]|[9-9][0-9])|rustc ([2-9][0-9]*)\.'; then
    echo "Rust hệ thống có thể chưa đạt 1.88."
    echo "Cài Rust stable trong tài khoản người dùng bằng rustup."

    if ! command -v rustup >/dev/null 2>&1; then
        echo "Cài rustup từ https://rustup.rs/ rồi chạy lại script."
        exit 1
    fi

    rustup toolchain install stable
    rustup default stable
fi

echo
echo "=== 3. Tạo thư mục source mới ==="
mkdir -p "$SOURCE_ROOT"

STAMP="$(date +%Y%m%d-%H%M%S)"
DEST="${SOURCE_ROOT}/ngosen-${STAMP}"

echo "Source mới: $DEST"
git clone --recurse-submodules "$REPO_URL" "$DEST"

echo
echo "=== 4. Lưu thông tin source ==="
{
    echo "Repository: $REPO_URL"
    echo "Branch/commit:"
    git -C "$DEST" log -1 --oneline
    echo
    echo "Rust:"
    rustc --version
    cargo --version
    echo
    echo "CMake:"
    cmake --version | head -n 1
} | tee "$DEST/SOURCE-INFO.txt"

echo
echo "=== HOÀN TẤT ==="
echo "Source nguyên bản: $DEST"
echo "Hướng dẫn build của dự án: $DEST/TU-DUNG.md"
echo "Không có bộ gõ nào được cài hoặc gỡ bởi script này."
echo
echo "Mỗi lần chạy lại, script tạo một thư mục source mới."
