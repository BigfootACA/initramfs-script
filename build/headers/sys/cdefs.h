#ifndef _SYS_CDEFS_H
#define _SYS_CDEFS_H
#undef __P
#define __P(arg) arg
#ifdef __cplusplus
# define __BEGIN_DECLS extern "C" {
# define __END_DECLS   }
#else
# define __BEGIN_DECLS
# define __END_DECLS
#endif
#ifndef __cplusplus
# define __THROW  __attribute__ ((__nothrow__))
# define __NTH(f) __attribute__ ((__nothrow__)) f
#else
# define __THROW
# define __NTH(f) f
#endif
#endif
