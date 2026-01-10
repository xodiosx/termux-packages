TERMUX_PKG_HOMEPAGE=https://virgil3d.github.io/
TERMUX_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.0.1.1
TERMUX_PKG_SRCURL=https://github.com/xodiosx/virglrenderer-venus1.0/archive/refs/tags/1.0.1.1.tar.gz
TERMUX_PKG_SHA256=9f8838fec3c025f1c2bcce12b3a9217a907a877c98dc017fde36e712b5088933
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libdrm, libepoxy, libglvnd, libx11, mesa"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dplatforms=egl,glx"

termux_step_pre_configure() {
    # Disable Clang offsetof extension error
    CPPFLAGS+=" -Wno-error=gnu-offsetof-extensions"

    if [[ $TERMUX_ARCH != "arm" ]]; then
        TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvenus=true"
    fi
}
