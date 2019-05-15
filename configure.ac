AC_INIT(apm, 0.1.0, nikita.dudko.95@gmail.com)
AC_SUBST(VERSION, 0.1.0)

AC_LANG(C++)
AC_PROG_CXX
AC_CONFIG_FILES(Makefile)
AX_CHECK_COMPILE_FLAG([-lstdc++fs], [], [AC_MSG_ERROR(m4_normalize([
    Your compiler doesn't provide the standard Filesystem library!
]))])

AC_CHECK_PROG(CURL, curl, yes, no)
if test "$CURL" != yes; then
  AC_MSG_ERROR([curl should be installed to download dependencies.])
fi

AC_CHECK_PROG(JQ, jq, yes, no)
if test "$JQ" != yes; then
  AC_MSG_ERROR([jq should be installed to retrieve dependencies.])
fi

AC_CHECK_PROG(CMAKE, cmake, yes, no)
if test "$CMAKE" != yes; then
  AC_MSG_ERROR([cmake should be installed to build dependencies.])
fi

AC_CHECK_LIB(pugixml, main, [],
    [AC_MSG_ERROR([pugixml library (libpugixml-dev) didn't find!])])
AC_CHECK_LIB(curl, main, [],
    [AC_MSG_ERROR([curl library (libcurl4-openssl-dev) didn't find!])])

AC_MSG_NOTICE([Checking packages needed for build .deb package...])
AC_CHECK_PROG(PANDOC, pandoc, yes, no)
AC_CHECK_PROG(GZIP, gzip, yes, no)
AC_CHECK_PROG(FAKEROOT, fakeroot, yes, no)
AC_CHECK_PROG(DPKG_DEB, dpkg-deb, yes, no)

if test "$PANDOC" != yes -o "$GZIP" != yes -o \
    "$FAKEROOT" != yes -o "$DPKG_DEB" != yes; then
  AC_MSG_WARN(m4_normalize([
      The Debian package build support disabled,
      as some needed packages didn't install.
  ]))
  dnl Hide a rule for building .deb package.
  AC_SUBST(DEB, .deb-disabled)
else
  AC_CONFIG_FILES(scripts/make-deb.sh, [chmod +x scripts/make-deb.sh])
  AC_SUBST(DEB, deb)
fi

AC_OUTPUT
AC_MSG_NOTICE([Now build dependencies: make libs.])
