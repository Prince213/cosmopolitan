#-*-mode:makefile-gmake;indent-tabs-mode:t;tab-width:8;coding:utf-8-*-┐
#───vi: set et ft=make ts=8 tw=8 fenc=utf-8 :vi───────────────────────┘

PKGS += TOOL_NET

TOOL_NET_FILES := $(wildcard tool/net/*)
TOOL_NET_SRCS = $(filter %.c,$(TOOL_NET_FILES))
TOOL_NET_HDRS = $(filter %.h,$(TOOL_NET_FILES))

TOOL_NET_OBJS =									\
	$(TOOL_NET_SRCS:%.c=o/$(MODE)/%.o)

TOOL_NET_BINS =									\
	$(TOOL_NET_COMS)							\
	$(TOOL_NET_COMS:%=%.dbg)

TOOL_NET_COMS =									\
	o/$(MODE)/tool/net/dig.com						\
	o/$(MODE)/tool/net/redbean.com						\
	o/$(MODE)/tool/net/redbean-demo.com					\
	o/$(MODE)/tool/net/redbean-static.com					\
	o/$(MODE)/tool/net/redbean-unsecure.com					\
	o/$(MODE)/tool/net/redbean-original.com					\
	o/$(MODE)/tool/net/wb.com

TOOL_NET_CHECKS =								\
	o/$(MODE)/tool/net/net.pkg						\
	$(TOOL_NET_HDRS:%=o/$(MODE)/%.ok)

TOOL_NET_DIRECTDEPS =								\
	DSP_SCALE								\
	LIBC_ALG								\
	LIBC_BITS								\
	LIBC_CALLS								\
	LIBC_DNS								\
	LIBC_FMT								\
	LIBC_INTRIN								\
	LIBC_LOG								\
	LIBC_MEM								\
	LIBC_NEXGEN32E								\
	LIBC_NT_IPHLPAPI							\
	LIBC_NT_KERNEL32							\
	LIBC_RAND								\
	LIBC_RUNTIME								\
	LIBC_SOCK								\
	LIBC_STDIO								\
	LIBC_STR								\
	LIBC_STUBS								\
	LIBC_SYSV								\
	LIBC_SYSV_CALLS								\
	LIBC_TIME								\
	LIBC_THREAD								\
	LIBC_TINYMATH								\
	LIBC_UNICODE								\
	LIBC_X									\
	LIBC_ZIPOS								\
	NET_FINGER								\
	NET_HTTP								\
	NET_HTTPS								\
	THIRD_PARTY_ARGON2							\
	THIRD_PARTY_GDTOA							\
	THIRD_PARTY_GETOPT							\
	THIRD_PARTY_LINENOISE							\
	THIRD_PARTY_LUA								\
	THIRD_PARTY_LUA_UNIX							\
	THIRD_PARTY_MAXMIND							\
	THIRD_PARTY_MBEDTLS							\
	THIRD_PARTY_REGEX							\
	THIRD_PARTY_SQLITE3							\
	THIRD_PARTY_ZLIB							\
	TOOL_ARGS								\
	TOOL_BUILD_LIB								\
	TOOL_DECODE_LIB								\
	THIRD_PARTY_DOUBLECONVERSION

TOOL_NET_DEPS :=								\
	$(call uniq,$(foreach x,$(TOOL_NET_DIRECTDEPS),$($(x))))

o/$(MODE)/tool/net/net.pkg:							\
		$(TOOL_NET_OBJS)						\
		$(foreach x,$(TOOL_NET_DIRECTDEPS),$($(x)_A).pkg)

o/$(MODE)/tool/net/%.com.dbg:							\
		$(TOOL_NET_DEPS)						\
		o/$(MODE)/tool/net/%.o						\
		o/$(MODE)/tool/net/net.pkg					\
		$(CRT)								\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

# REDBEAN.COM
#
# The little web server that could!

o/$(MODE)/tool/net/redbean.com.dbg:						\
		$(TOOL_NET_DEPS)						\
		o/$(MODE)/tool/net/redbean.o					\
		o/$(MODE)/tool/net/lfuncs.o					\
		o/$(MODE)/tool/net/lpath.o					\
		o/$(MODE)/tool/net/lfinger.o					\
		o/$(MODE)/tool/net/lre.o					\
		o/$(MODE)/tool/net/ljson.o					\
		o/$(MODE)/tool/net/lmaxmind.o					\
		o/$(MODE)/tool/net/lsqlite3.o					\
		o/$(MODE)/tool/net/largon2.o					\
		o/$(MODE)/tool/net/net.pkg					\
		o/$(MODE)/tool/net/help.txt.zip.o				\
		o/$(MODE)/tool/net/.init.lua.zip.o				\
		o/$(MODE)/tool/net/favicon.ico.zip.o				\
		o/$(MODE)/tool/net/redbean.png.zip.o				\
		$(CRT)								\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

o/$(MODE)/tool/net/redbean.com:							\
		o/$(MODE)/tool/net/redbean.com.dbg				\
		o/$(MODE)/tool/build/symtab.com
	@$(COMPILE) -AOBJCOPY -T$@ $(OBJCOPY) -S -O binary $< $@
	@$(COMPILE) -ASYMTAB o/$(MODE)/tool/build/symtab.com -o $(SYMTAB) $<
	@$(COMPILE) -AZIP -T$@ $@ -A $(SYMTAB)

# REDBEAN-DEMO.COM
#
# This redbean-demo.com program is the same as redbean.com except it
# bundles a bunch of example code and there's a live of it available
# online at http://redbean.justine.lol/

o/$(MODE)/tool/net/.init.lua.zip.o						\
o/$(MODE)/tool/net/demo/.init.lua.zip.o						\
o/$(MODE)/tool/net/demo/.reload.lua.zip.o					\
o/$(MODE)/tool/net/demo/sql.lua.zip.o						\
o/$(MODE)/tool/net/demo/unix-unix.lua.zip.o					\
o/$(MODE)/tool/net/demo/unix-rawsocket.lua.zip.o				\
o/$(MODE)/tool/net/demo/unix-subprocess.lua.zip.o				\
o/$(MODE)/tool/net/demo/unix-webserver.lua.zip.o				\
o/$(MODE)/tool/net/demo/unix-dir.lua.zip.o					\
o/$(MODE)/tool/net/demo/unix-info.lua.zip.o					\
o/$(MODE)/tool/net/demo/unix-finger.lua.zip.o					\
o/$(MODE)/tool/net/demo/fetch.lua.zip.o						\
o/$(MODE)/tool/net/demo/finger.lua.zip.o					\
o/$(MODE)/tool/net/demo/call-lua-module.lua.zip.o				\
o/$(MODE)/tool/net/demo/store-asset.lua.zip.o					\
o/$(MODE)/tool/net/demo/maxmind.lua.zip.o					\
o/$(MODE)/tool/net/demo/redbean.lua.zip.o					\
o/$(MODE)/tool/net/demo/opensource.lua.zip.o					\
o/$(MODE)/tool/net/demo/binarytrees.lua.zip.o					\
o/$(MODE)/tool/net/demo/crashreport.lua.zip.o					\
o/$(MODE)/tool/net/demo/closedsource.lua.zip.o					\
o/$(MODE)/tool/net/demo/printpayload.lua.zip.o					\
o/$(MODE)/tool/net/demo/gensvg.lua.zip.o					\
o/$(MODE)/tool/net/demo/redbean-form.lua.zip.o					\
o/$(MODE)/tool/net/demo/redbean-xhr.lua.zip.o					\
o/$(MODE)/tool/net/redbean.png.zip.o						\
o/$(MODE)/tool/net/favicon.ico.zip.o						\
o/$(MODE)/tool/net/help.txt.zip.o						\
o/$(MODE)/tool/net/demo/404.html.zip.o:						\
		ZIPOBJ_FLAGS +=							\
			-B

o/$(MODE)/tool/net/demo/.lua/.zip.o						\
o/$(MODE)/tool/net/demo/.lua/mymodule.lua.zip.o:				\
		ZIPOBJ_FLAGS +=							\
			-C3

o/$(MODE)/tool/net/demo/seekable.txt.zip.o:					\
		ZIPOBJ_FLAGS +=							\
			-B							\
			-0

o/$(MODE)/tool/net/demo/virtualbean.html.zip.o:					\
		ZIPOBJ_FLAGS +=							\
			-Predbean.justine.lol					\
			-B

o/$(MODE)/tool/net/redbean-demo.com.dbg:					\
		$(TOOL_NET_DEPS)						\
		o/$(MODE)/tool/net/redbean.o					\
		o/$(MODE)/tool/net/lfuncs.o					\
		o/$(MODE)/tool/net/lpath.o					\
		o/$(MODE)/tool/net/lfinger.o					\
		o/$(MODE)/tool/net/lre.o					\
		o/$(MODE)/tool/net/ljson.o					\
		o/$(MODE)/tool/net/lmaxmind.o					\
		o/$(MODE)/tool/net/lsqlite3.o					\
		o/$(MODE)/tool/net/largon2.o					\
		o/$(MODE)/tool/net/net.pkg					\
		o/$(MODE)/tool/net/demo/sql.lua.zip.o				\
		o/$(MODE)/tool/net/demo/unix-unix.lua.zip.o			\
		o/$(MODE)/tool/net/demo/unix-rawsocket.lua.zip.o		\
		o/$(MODE)/tool/net/demo/unix-subprocess.lua.zip.o		\
		o/$(MODE)/tool/net/demo/unix-webserver.lua.zip.o		\
		o/$(MODE)/tool/net/demo/unix-dir.lua.zip.o			\
		o/$(MODE)/tool/net/demo/unix-info.lua.zip.o			\
		o/$(MODE)/tool/net/demo/unix-finger.lua.zip.o			\
		o/$(MODE)/tool/net/demo/fetch.lua.zip.o				\
		o/$(MODE)/tool/net/demo/finger.lua.zip.o			\
		o/$(MODE)/tool/net/demo/store-asset.lua.zip.o			\
		o/$(MODE)/tool/net/demo/call-lua-module.lua.zip.o		\
		o/$(MODE)/tool/net/demo/redbean.lua.zip.o			\
		o/$(MODE)/tool/net/demo/maxmind.lua.zip.o			\
		o/$(MODE)/tool/net/demo/opensource.lua.zip.o			\
		o/$(MODE)/tool/net/demo/binarytrees.lua.zip.o			\
		o/$(MODE)/tool/net/demo/crashreport.lua.zip.o			\
		o/$(MODE)/tool/net/demo/closedsource.lua.zip.o			\
		o/$(MODE)/tool/net/demo/printpayload.lua.zip.o			\
		o/$(MODE)/tool/net/demo/gensvg.lua.zip.o			\
		o/$(MODE)/tool/net/demo/redbean-form.lua.zip.o			\
		o/$(MODE)/tool/net/demo/redbean-xhr.lua.zip.o			\
		o/$(MODE)/tool/.zip.o						\
		o/$(MODE)/tool/net/.zip.o					\
		o/$(MODE)/tool/net/demo/.zip.o					\
		o/$(MODE)/tool/net/demo/index.html.zip.o			\
		o/$(MODE)/tool/net/demo/redbean.css.zip.o			\
		o/$(MODE)/tool/net/redbean.png.zip.o				\
		o/$(MODE)/tool/net/favicon.ico.zip.o				\
		o/$(MODE)/tool/net/demo/404.html.zip.o				\
		o/$(MODE)/tool/net/demo/seekable.txt.zip.o			\
		o/$(MODE)/tool/net/demo/virtualbean.html.zip.o			\
		o/$(MODE)/tool/net/demo/.lua/.zip.o				\
		o/$(MODE)/tool/net/demo/.lua/mymodule.lua.zip.o			\
		o/$(MODE)/tool/net/demo/.reload.lua.zip.o			\
		o/$(MODE)/tool/net/demo/.init.lua.zip.o				\
		o/$(MODE)/tool/net/help.txt.zip.o				\
		$(CRT)								\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

o/$(MODE)/tool/net/redbean-demo.com:						\
		o/$(MODE)/tool/net/redbean-demo.com.dbg				\
		o/$(MODE)/tool/build/symtab.com
	@$(COMPILE) -AOBJCOPY -T$@ $(OBJCOPY) -S -O binary $< $@
	@$(COMPILE) -ASYMTAB o/$(MODE)/tool/build/symtab.com -o $(SYMTAB) $<
	@$(COMPILE) -AZIP -T$@ $@ -A $(SYMTAB)

# REDBEAN-STATIC.COM
#
# Passing the -DSTATIC causes Lua and SQLite to be removed. This reduces
# the binary size from roughly 1500 kb to 500 kb. It still supports SSL.

o/$(MODE)/tool/net/redbean-static.com.dbg:					\
		$(TOOL_NET_DEPS)						\
		o/$(MODE)/tool/net/redbean-static.o				\
		o/$(MODE)/tool/net/net.pkg					\
		o/$(MODE)/tool/net/favicon.ico.zip.o				\
		o/$(MODE)/tool/net/redbean.png.zip.o				\
		o/$(MODE)/tool/net/help.txt.zip.o				\
		$(CRT)								\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

# REDBEAN-UNSECURE.COM
#
# Passing the -DUNSECURE will cause the TLS security code to be removed.
# That doesn't mean redbean becomes insecure. It just reduces complexity
# in situations where you'd rather have SSL be handled in an edge proxy.

o/$(MODE)/tool/net/redbean-unsecure.com.dbg:					\
		$(TOOL_NET_DEPS)						\
		o/$(MODE)/tool/net/redbean-unsecure.o				\
		o/$(MODE)/tool/net/lfuncs.o					\
		o/$(MODE)/tool/net/lpath.o					\
		o/$(MODE)/tool/net/lfinger.o					\
		o/$(MODE)/tool/net/lre.o					\
		o/$(MODE)/tool/net/ljson.o					\
		o/$(MODE)/tool/net/lmaxmind.o					\
		o/$(MODE)/tool/net/lsqlite3.o					\
		o/$(MODE)/tool/net/largon2.o					\
		o/$(MODE)/tool/net/net.pkg					\
		o/$(MODE)/tool/net/favicon.ico.zip.o				\
		o/$(MODE)/tool/net/redbean.png.zip.o				\
		o/$(MODE)/tool/net/help.txt.zip.o				\
		$(CRT)								\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

# REDBEAN-ORIGINAL.COM
#
# Passing the -DSTATIC and -DUNSECURE flags together w/ MODE=tiny will
# produce 200kb binary that's very similar to redbean as it existed on
# Hacker News the day it went viral.

o/$(MODE)/tool/net/redbean-original.com.dbg:					\
		$(TOOL_NET_DEPS)						\
		o/$(MODE)/tool/net/redbean-original.o				\
		o/$(MODE)/tool/net/net.pkg					\
		o/$(MODE)/tool/net/favicon.ico.zip.o				\
		o/$(MODE)/tool/net/redbean.png.zip.o				\
		o/$(MODE)/tool/net/help.txt.zip.o				\
		$(CRT)								\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

.PHONY: o/$(MODE)/tool/net
o/$(MODE)/tool/net:								\
		$(TOOL_NET_BINS)						\
		$(TOOL_NET_CHECKS)
