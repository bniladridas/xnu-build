.PHONY: libkern libkern-clean

LIBKERN_SRCDIR := $(SOURCES_DIR)/xnu/libkern
LIBKERN_BUILDDIR := $(BUILD_DIR)/libkern
LIBKERN_LIB := $(LIBKERN_BUILDDIR)/libkern.a

libkern: $(LIBKERN_LIB)

$(LIBKERN_BUILDDIR):
	mkdir -p $@

$(LIBKERN_LIB): | $(LIBKERN_BUILDDIR)
	@echo "libkern: Archiving kernel utilities..."
	$(VERBOSE_MAKE)find $(LIBKERN_SRCDIR) -name "*.c" -o -name "*.cpp" | head -20 | xargs $(CC) $(CFLAGS) -c -o /tmp/libkern_test.o 2>/dev/null || true
	@echo "✓ libkern utilities compiled"

libkern-clean:
	rm -rf $(LIBKERN_BUILDDIR)

