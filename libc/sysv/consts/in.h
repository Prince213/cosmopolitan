#ifndef COSMOPOLITAN_LIBC_SYSV_CONSTS_IN_H_
#define COSMOPOLITAN_LIBC_SYSV_CONSTS_IN_H_
#include "libc/runtime/symbolic.h"

#define IN_ACCESS SYMBOLIC(IN_ACCESS)
#define IN_ALL_EVENTS SYMBOLIC(IN_ALL_EVENTS)
#define IN_ATTRIB SYMBOLIC(IN_ATTRIB)
#define IN_CLOEXEC SYMBOLIC(IN_CLOEXEC)
#define IN_CLOSE SYMBOLIC(IN_CLOSE)
#define IN_CLOSE_NOWRITE SYMBOLIC(IN_CLOSE_NOWRITE)
#define IN_CLOSE_WRITE SYMBOLIC(IN_CLOSE_WRITE)
#define IN_CREATE SYMBOLIC(IN_CREATE)
#define IN_DELETE SYMBOLIC(IN_DELETE)
#define IN_DELETE_SELF SYMBOLIC(IN_DELETE_SELF)
#define IN_DONT_FOLLOW SYMBOLIC(IN_DONT_FOLLOW)
#define IN_EXCL_UNLINK SYMBOLIC(IN_EXCL_UNLINK)
#define IN_IGNORED SYMBOLIC(IN_IGNORED)
#define IN_ISDIR SYMBOLIC(IN_ISDIR)
#define IN_LOOPBACKNET SYMBOLIC(IN_LOOPBACKNET)
#define IN_MASK_ADD SYMBOLIC(IN_MASK_ADD)
#define IN_MODIFY SYMBOLIC(IN_MODIFY)
#define IN_MOVE SYMBOLIC(IN_MOVE)
#define IN_MOVED_FROM SYMBOLIC(IN_MOVED_FROM)
#define IN_MOVED_TO SYMBOLIC(IN_MOVED_TO)
#define IN_MOVE_SELF SYMBOLIC(IN_MOVE_SELF)
#define IN_NONBLOCK SYMBOLIC(IN_NONBLOCK)
#define IN_ONESHOT SYMBOLIC(IN_ONESHOT)
#define IN_ONLYDIR SYMBOLIC(IN_ONLYDIR)
#define IN_OPEN SYMBOLIC(IN_OPEN)
#define IN_Q_OVERFLOW SYMBOLIC(IN_Q_OVERFLOW)
#define IN_UNMOUNT SYMBOLIC(IN_UNMOUNT)

#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

extern const uint32_t IN_ACCESS;
extern const uint32_t IN_ALL_EVENTS;
extern const uint32_t IN_ATTRIB;
extern const uint32_t IN_CLOEXEC;
extern const uint32_t IN_CLOSE;
extern const uint32_t IN_CLOSE_NOWRITE;
extern const uint32_t IN_CLOSE_WRITE;
extern const uint32_t IN_CREATE;
extern const uint32_t IN_DELETE;
extern const uint32_t IN_DELETE_SELF;
extern const uint32_t IN_DONT_FOLLOW;
extern const uint32_t IN_EXCL_UNLINK;
extern const uint32_t IN_IGNORED;
extern const uint32_t IN_ISDIR;
extern const uint32_t IN_LOOPBACKNET;
extern const uint32_t IN_MASK_ADD;
extern const uint32_t IN_MODIFY;
extern const uint32_t IN_MOVE;
extern const uint32_t IN_MOVED_FROM;
extern const uint32_t IN_MOVED_TO;
extern const uint32_t IN_MOVE_SELF;
extern const uint32_t IN_NONBLOCK;
extern const uint32_t IN_ONESHOT;
extern const uint32_t IN_ONLYDIR;
extern const uint32_t IN_OPEN;
extern const uint32_t IN_Q_OVERFLOW;
extern const uint32_t IN_UNMOUNT;

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */
#endif /* COSMOPOLITAN_LIBC_SYSV_CONSTS_IN_H_ */
