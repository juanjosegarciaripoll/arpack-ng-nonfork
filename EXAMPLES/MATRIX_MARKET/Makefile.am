LDADD = $(top_builddir)/SRC/libarpack$(LIBSUFFIX)$(ITF64SUFFIX).la
AM_CPPFLAGS = -I$(top_builddir) -I$(top_srcdir)/ICB $(EIGEN3_CFLAGS)

EXTRA_DIST = README

check_PROGRAMS = arpackmm
dist_check_SCRIPTS = arpackmm.sh
dist_check_DATA = An.mtx As.mtx Az.mtx B.mtx Bz.mtx
TESTS = arpackmm.sh

arpackmm_SOURCES = arpackmm.cpp

if ICBEXMM
pkginclude_HEADERS = arpackSolver.hpp
endif

CLEANFILES = \
	arpackmm.run.log \
	arpackmm.resid.out \
	arpackmm.v.out \
	arpackSolver.resid.out \
	arpackSolver.v.out
