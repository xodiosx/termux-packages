TERMUX_PKG_HOMEPAGE=https://github.com/tokokudo/gl4es
TERMUX_PKG_DESCRIPTION="OpenGL driver for GLES devices"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"

_COMMIT=ad8e385628481cd180dcc8bd67b154952d9ac3cd
_COMMIT_DATE=20260215
_COMMIT_TIME=083421

TERMUX_PKG_VERSION="1.1.6.20260215.083421gad8e3856"

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
	export CFLAGS="${CFLAGS/-Oz/-O2} -flto"
}

termux_step_post_make_install() {
	rm -fr "${TERMUX_PREFIX}/lib/gl4es/libGL.so"
	ln -fs "libGL.so.1" "${TERMUX_PREFIX}/lib/gl4es/libGL.so"
}
