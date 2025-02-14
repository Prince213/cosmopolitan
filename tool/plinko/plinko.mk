#-*-mode:makefile-gmake;indent-tabs-mode:t;tab-width:8;coding:utf-8-*-┐
#───vi: set et ft=make ts=8 tw=8 fenc=utf-8 :vi───────────────────────┘

PKGS += TOOL_PLINKO

TOOL_PLINKO_SRCS := $(wildcard tool/plinko/*.c)

TOOL_PLINKO_OBJS =						\
	$(TOOL_PLINKO_SRCS:%.c=o/$(MODE)/%.o)

TOOL_PLINKO_COMS =						\
	$(TOOL_PLINKO_SRCS:%.c=o/$(MODE)/%.com)

TOOL_PLINKO_BINS =						\
	$(TOOL_PLINKO_COMS)					\
	$(TOOL_PLINKO_COMS:%=%.dbg)

TOOL_PLINKO_DIRECTDEPS =					\
	LIBC_INTRIN						\
	LIBC_LOG						\
	LIBC_MEM						\
	LIBC_CALLS						\
	LIBC_RUNTIME						\
	LIBC_UNICODE						\
	LIBC_SYSV						\
	LIBC_STDIO						\
	LIBC_X							\
	LIBC_STUBS						\
	LIBC_NEXGEN32E						\
	LIBC_ZIPOS						\
	TOOL_PLINKO_LIB

TOOL_PLINKO_DEPS :=						\
	$(call uniq,$(foreach x,$(TOOL_PLINKO_DIRECTDEPS),$($(x))))

o/$(MODE)/tool/plinko/plinko.pkg:				\
		$(TOOL_PLINKO_OBJS)				\
		$(foreach x,$(TOOL_PLINKO_DIRECTDEPS),$($(x)_A).pkg)

o/$(MODE)/tool/plinko/%.com.dbg:				\
		$(TOOL_PLINKO_DEPS)				\
		o/$(MODE)/tool/plinko/%.o			\
		o/$(MODE)/tool/plinko/plinko.pkg		\
		o/$(MODE)/tool/plinko/lib/library.lisp.zip.o	\
		$(CRT)						\
		$(APE_NO_MODIFY_SELF)
	@$(APELINK)

$(TOOL_PLINKO_OBJS):						\
		$(BUILD_FILES)					\
		tool/plinko/plinko.mk

o/$(MODE)/tool/plinko/lib/library.lisp.zip.o			\
o/$(MODE)/tool/plinko/lib/binarytrees.lisp.zip.o		\
o/$(MODE)/tool/plinko/lib/algebra.lisp.zip.o			\
o/$(MODE)/tool/plinko/lib/infix.lisp.zip.o			\
o/$(MODE)/tool/plinko/lib/ok.lisp.zip.o:			\
		ZIPOBJ_FLAGS +=					\
			-B

o/$(MODE)/tool/plinko/plinko.com.zip.o:				\
		o/$(MODE)/tool/plinko/plinko.com
	@$(COMPILE) -AZIPOBJ $(ZIPOBJ) $(ZIPOBJ_FLAGS) -B $(OUTPUT_OPTION) $<

.PHONY: o/$(MODE)/tool/plinko
o/$(MODE)/tool/plinko: $(TOOL_PLINKO_BINS) $(TOOL_PLINKO_CHECKS)

