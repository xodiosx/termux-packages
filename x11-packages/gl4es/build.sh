TERMUX_PKG_HOMEPAGE=https://github.com/tokokudo/gl4es
TERMUX_PKG_DESCRIPTION="OpenGL driver for GLES devices"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"

_COMMIT=661bb5607116e6a48a7cb004ad7cb414a138f710
_COMMIT_DATE=20260215
_COMMIT_TIME=080631

TERMUX_PKG_VERSION="1.1.6.20260215.080631g661bb560"

TERMUX_PKG_SRCURL=git+https://github.com/tokokudo/gl4es
TERMUX_PKG_GIT_BRANCH=master

TERMUX_PKG_DEPENDS="libx11"
TERMUX_PKG_AUTO_UPDATE=false

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DTERMUX=ON
-DANDROID=OFF
-DNOX11=OFF
-DCMAKE_SYSTEM_NAME=Linux
"

termux_step_post_get_source() {
	git fetch --unshallow || true
	git checkout "${_COMMIT}"
}

termux_step_pre_configure() {
	# benchmark result as follows:
	# -O2 -flto > -O3 -flto > -O2 > -Os > -Os -flto > -O3 > -Oz > -Oz -flto
	export CFLAGS="${CFLAGS/-Oz/-O2} -flto"
}

termux_step_post_make_install() {
	rm -fr "${TERMUX_PREFIX}/lib/gl4es/libGL.so"
	ln -fs "libGL.so.1" "${TERMUX_PREFIX}/lib/gl4es/libGL.so"
}
