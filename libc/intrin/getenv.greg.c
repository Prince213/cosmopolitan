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
#include "libc/assert.h"
#include "libc/calls/strace.internal.h"
#include "libc/dce.h"
#include "libc/errno.h"
#include "libc/intrin/kprintf.h"
#include "libc/log/libfatal.internal.h"
#include "libc/runtime/runtime.h"

forceinline int Identity(int c) {
  return c;
}

forceinline int ToUpper(int c) {
  return 'a' <= c && c <= 'z' ? c - ('a' - 'A') : c;
}

forceinline char *GetEnv(const char *s, int xlat(int)) {
  char **p;
  size_t i, j;
  if ((p = environ)) {
    for (i = 0; p[i]; ++i) {
      for (j = 0;; ++j) {
        if (!s[j]) {
          if (p[i][j] == '=') {
            return p[i] + j + 1;
          }
          break;
        }
        if (xlat(s[j]) != xlat(p[i][j])) {
          break;
        }
      }
    }
  }
  return 0;
}

/**
 * Returns value of environment variable, or NULL if not found.
 *
 * Environment variables can store empty string on Unix but not Windows.
 *
 * @note should not be used after __cxa_finalize() is called
 */
char *getenv(const char *s) {
  char *r;
  if (!s) return 0;
  if (!IsWindows()) {
    r = GetEnv(s, Identity);
  } else {
    r = GetEnv(s, ToUpper);
  }
#if SYSDEBUG
  if (!(s[0] == 'T' && s[1] == 'Z' && !s[2])) {
    // TODO(jart): memoize TZ or something
    STRACE("getenv(%#s) → %#s", s, r);
  }
#endif
  return r;
}
