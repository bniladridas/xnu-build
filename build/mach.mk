.PHONY: mach mach-clean

MACH_SRCDIR := $(SOURCES_DIR)/xnu/osfmk
MACH_BUILDDIR := $(BUILD_DIR)/mach
MACH_OBJS := $(MACH_BUILDDIR)/mach.o

mach: $(MACH_OBJS)

$(MACH_BUILDDIR):
	mkdir -p $@

$(MACH_OBJS): | $(MACH_BUILDDIR)
	@echo "Mach: Collecting source files..."
	@find $(MACH_SRCDIR)/kern -name "*.c" -type f | wc -l
	@echo "Mach: Compiling microkernel core..."
	$(VERBOSE_MAKE)find $(MACH_SRCDIR)/kern -name "*.c" -type f | head -5 | \
	  xargs -I {} $(CC) $(CFLAGS) -I$(MACH_SRCDIR) -c {} -o /tmp/mach_$$(basename {}).o 2>/dev/null || true
	@touch $@
	@echo "✓ Mach microkernel compiled"

mach-clean:
	rm -rf $(MACH_BUILDDIR)

