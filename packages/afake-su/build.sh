TERMUX_PKG_HOMEPAGE="https://github.com/httpspycharmhelpers/aFakeSU"
TERMUX_PKG_DESCRIPTION="A fake su implementation based on proot"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@httpspycharmhelpers"
TERMUX_PKG_VERSION="1.0.0"
# 使用你上传的 Release 附件 zip 的链接
TERMUX_PKG_SRCURL="https://github.com/httpspycharmhelpers/aFakeSU/releases/download/1.0.0/aFakeSU-src.zip"
# SHA256 先留空，第一次构建时会提示正确值
TERMUX_PKG_SHA256="d93162c8bd0763922329b7f0ba00699317aec20a8912804bdd003fe40aaca092"
TERMUX_PKG_BUILD_DEPENDS="clang, make, binutils"
TERMUX_PKG_BUILD_IN_SRC=true
termux_step_pre_configure() {
    ls -l "$TERMUX_PKG_SRCDIR"
    cd "$TERMUX_PKG_SRCDIR/src"
}

termux_step_make() {
    cd "$TERMUX_PKG_SRCDIR/src"
    bash build_su.sh
    
}

termux_step_make_install() {
    # 1. 主程序（从 src/ 目录复制）
    install -Dm700 "$TERMUX_PKG_SRCDIR/src/fakesu.elf" "$TERMUX_PREFIX/bin/fakesu"
    
    # 2. rish 助手（从根目录复制）
    install -Dm700 "$TERMUX_PKG_SRCDIR/rish" "$TERMUX_PREFIX/bin/rish"
    
    # 3. rishq 工具（从根目录复制）
    install -Dm700 "$TERMUX_PKG_SRCDIR/rishq" "$TERMUX_PREFIX/bin/rishq"
    
    # 4. rish_shizuku.dex（放到 share 目录作为数据文件）
    install -Dm644 "$TERMUX_PKG_SRCDIR/rish_shizuku.dex" "$TERMUX_PREFIX/share/afake-su/rish_shizuku.dex"
    
    # 5. afake-su 启动脚本（可执行，放到 bin 目录）
    install -Dm700 "$TERMUX_PKG_SRCDIR/afake-su" "$TERMUX_PREFIX/bin/afake-su"
}
