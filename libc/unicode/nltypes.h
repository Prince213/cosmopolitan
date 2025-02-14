#ifndef COSMOPOLITAN_LIBC_UNICODE_NLTYPES_H_
#define COSMOPOLITAN_LIBC_UNICODE_NLTYPES_H_

#define NL_SETD       1
#define NL_CAT_LOCALE 1

#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

typedef int nl_item;
typedef void *nl_catd;

nl_catd catopen(const char *, int);
char *catgets(nl_catd, int, int, const char *);
int catclose(nl_catd);

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */
#endif /* COSMOPOLITAN_LIBC_UNICODE_NLTYPES_H_ */
