PACKAGES = go node python ruby

.PHONY: all
all: shell $(PACKAGES)

.PHONY: shell
shell:
	scripts/install.sh symlink

.PHONY: $(PACKAGES)
$(PACKAGES):
	$@/install.sh
