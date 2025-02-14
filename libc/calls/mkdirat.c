/*-*- mode:c;indent-tabs-mode:nil;c-basic-offset:2;tab-width:8;coding:utf-8 -*-│
│vi: set net ft=c ts=2 sts=2 sw=2 fenc=utf-8                                :vi│
╞══════════════════════════════════════════════════════════════════════════════╡
│ Copyright 2020 Justine Alexandra Roberts Tunney                              │
│                                                                              │
│ Permission to use, copy, modify, and/or distribute this software for         │
│ any purpose with or without fee is hereby granted, provided that the         │
│ above copyright notice and this permission notice appear in all copies.      │
│                                                                              │
│ THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL                │
│ WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED                │
│ WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE             │
│ AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL         │
│ DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR        │
│ PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER               │
│ TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR             │
│ PERFORMANCE OF THIS SOFTWARE.                                                │
╚─────────────────────────────────────────────────────────────────────────────*/
#include "libc/bits/weaken.h"
#include "libc/calls/calls.h"
#include "libc/calls/strace.internal.h"
#include "libc/calls/syscall-nt.internal.h"
#include "libc/calls/syscall-sysv.internal.h"
#include "libc/dce.h"
#include "libc/intrin/asan.internal.h"
#include "libc/intrin/describeflags.internal.h"
#include "libc/sysv/consts/at.h"
#include "libc/sysv/errfuns.h"
#include "libc/zipos/zipos.internal.h"

/**
 * Creates directory a.k.a. folder.
 *
 * @param dirfd is normally AT_FDCWD but if it's an open directory and
 *     path is relative, then path becomes relative to dirfd
 * @param path is a UTF-8 string, preferably relative w/ forward slashes
 * @param mode can be, for example, 0755
 * @return 0 on success or -1 w/ errno
 * @error EEXIST, ENOTDIR, ENAMETOOLONG, EACCES, ENOENT
 * @asyncsignalsafe
 * @see makedirs()
 */
int mkdirat(int dirfd, const char *path, unsigned mode) {
  int rc;
  if (IsAsan() && !__asan_is_valid(path, 1)) {
    rc = efault();
  } else if (weaken(__zipos_notat) && (rc = __zipos_notat(dirfd, path)) == -1) {
    STRACE("zipos mkdirat not supported yet");
  } else if (!IsWindows()) {
    rc = sys_mkdirat(dirfd, path, mode);
  } else {
    rc = sys_mkdirat_nt(dirfd, path, mode);
  }
  STRACE("mkdirat(%s, %#s, %#o) → %d% m", DescribeDirfd(dirfd), path, mode, rc);
  return rc;
}
