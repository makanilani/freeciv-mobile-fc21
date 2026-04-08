QT_CPU_FEATURES.x86_64 = 
QT.global_private.enabled_features = gc_binaries reduce_exports x86intrin sse2 sse3 ssse3 sse4_1 sse4_2 avx f16c avx2 avx512f avx512er avx512cd avx512pf avx512dq avx512bw avx512vl avx512ifma avx512vbmi avx512vbmi2 aesni vaes rdrnd rdseed shani localtime_r posix_fallocate alloca_h alloca system-zlib dbus dbus-linked gui network printsupport sql testlib widgets xml openssl dlopen relocatable intelcet glibc_fortify_source stack_protector stack_clash_protection libstdcpp_assertions relro_now_linker force_debug_info largefile precompile_header enable_new_dtags sse2 sse3 ssse3 sse4_1 sse4_2 avx f16c avx2 avx512f avx512er avx512cd avx512pf avx512dq avx512bw avx512vl avx512ifma avx512vbmi avx512vbmi2 aesni vaes rdrnd rdseed shani
QT.global_private.disabled_features = use_bfd_linker use_gold_linker use_lld_linker use_mold_linker android-style-assets developer-build private_tests debug elf_private_full_version no_direct_extern_access mips_dsp mips_dspr2 neon arm_crc32 arm_crypto localtime_s alloca_malloc_h stdlib-libcpp libudev trivial_auto_var_init_pattern libcpp_hardening
CONFIG += force_debug_info largefile precompile_header enable_new_dtags sse2 sse3 ssse3 sse4_1 sse4_2 avx f16c avx2 avx512f avx512er avx512cd avx512pf avx512dq avx512bw avx512vl avx512ifma avx512vbmi avx512vbmi2 aesni vaes rdrnd rdseed shani
PKG_CONFIG_EXECUTABLE = /bin/pkg-config
QT_COORD_TYPE = double
QT_BUILD_PARTS = libs tools

QMAKE_INCDIR_ZLIB = $$[QT_INSTALL_PREFIX]/include
QMAKE_LIBS_ZLIB = -L"$$[QT_INSTALL_PREFIX]/lib" -lz
QMAKE_INCDIR_ZSTD = $$[QT_INSTALL_PREFIX]/include
QMAKE_LIBS_ZSTD = -L"$$[QT_INSTALL_PREFIX]/lib" -lzstd
QMAKE_INCDIR_DBUS = $$[QT_INSTALL_PREFIX]/include/dbus-1.0 $$[QT_INSTALL_PREFIX]/lib/dbus-1.0/include
QMAKE_LIBS_DBUS = -L"$$[QT_INSTALL_PREFIX]/lib" -ldbus-1
