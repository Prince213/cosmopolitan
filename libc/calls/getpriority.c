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
#include "libc/calls/calls.h"
#include "libc/calls/strace.internal.h"
#include "libc/calls/syscall-nt.internal.h"
#include "libc/calls/syscall-sysv.internal.h"

/**
 * Returns nice value of thing.
 *
 * Since -1 might be a valid return value for this API, it's necessary
 * to clear `errno` beforehand and see if it changed, in order to truly
 * determine if an error happened.
 *
 * @param which can be PRIO_PROCESS, PRIO_PGRP, PRIO_USER
 * @param who is the pid, pgid, or uid (0 means current)
 * @return value ∈ [-NZERO,NZERO) or -1 w/ errno
 * @see setpriority(), nice()
 */
int getpriority(int which, unsigned who) {
  int rc;
  if (!IsWindows()) {
    if ((rc = sys_getpriority(which, who)) != -1) {
      rc = 20 - rc;
    }
  } else {
    rc = sys_getsetpriority_nt(which, who, 0, sys_getpriority_nt);
  }
  STRACE("getpriority(%d, %u) → %d% m", which, who, rc);
  return rc;
}
