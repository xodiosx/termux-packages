TERMUX_PKG_HOMEPAGE=https://virgil3d.github.io/
TERMUX_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.0.1.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/xodiosx/virglrenderer-venus1.0/archive/refs/tags/1.0.1.2.tar.gz
TERMUX_PKG_SHA256=8a0d6b20c147d2a01603db3482f014ab9f99ce53eec40b0e19a9897bef3213e9
TERMUX_PKG_AUTO_UPDATE=false
TERMUX_PKG_DEPENDS="libdrm, libepoxy, libglvnd, libx11, mesa"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dplatforms=egl,glx"

termux_step_pre_configure() {
	# Disable Clang offsetof extension error
	CPPFLAGS+=" -Wno-error=gnu-offsetof-extensions"

	# Enable Venus only on non-arm architectures
	if [[ $TERMUX_ARCH != "arm" ]]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvenus=true"
	fi
}
