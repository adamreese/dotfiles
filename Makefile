.PHONY: all
all: symlink
	./scripts/install.sh brew go python ruby

.PHONY: shell
shell:
	./scripts/install.sh symlink
