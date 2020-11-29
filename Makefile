SHELL = /bin/sh

.SUFFIXES:
.SUFFIXES: .d .pp

PPFLAGS ?= $(addprefix -D, $(shell ./ppflags.sh))

PROJDIR := $(realpath $(CURDIR))
SOURCEDIR := src
BUILDDIR := out

SCRIPTS := zshrc zshenv bash_profile bashrc
TARGETS := $(addprefix $(BUILDDIR)/, $(SCRIPTS))

.PHONY: all
all: $(TARGETS)

$(BUILDDIR)/:
	for d in $$(echo "$(dir $(TARGETS))" | xargs -n1 | uniq); do mkdir -p $$d; done

# this actually "compiles" the scripts in $SCRIPTS
%: %.d ppflags.sh
	set -e; pp \
		$(PPFLAGS) \
		$(SOURCEDIR)/$(@F).pp > $@

# use `pp` to output make prerequisite targets
$(BUILDDIR)/%.d: | $(BUILDDIR)/
	set -e; pp -M="$(BUILDDIR)/$* $@" $(SOURCEDIR)/$(*F).pp > $@;

# include the prerequisite targets output by pp
-include $(TARGETS:%=%.d)

.PHONY: clean
clean:
	-rm -rf $(BUILDDIR)

.PHONY: install
install: $(TARGETS)
	$(foreach f, $(SCRIPTS), install -m 0666 -T $(BUILDDIR)/$(f) $(HOME)/.$(f);)

