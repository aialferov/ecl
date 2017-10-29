PROJECT = ecl

EDITOR = vi
REBAR = ./rebar3

PREFIX = usr/local

BINDIR = bin
BINPATH = $(DESTDIR)/$(PREFIX)/$(BINDIR)
BINPATHIN := $(shell $(REBAR) path --bin)

BUILDDIR = _build

export QUIET = 1

all:
	$(REBAR) escriptize
	$(REBAR) unlock

clean:
	$(REBAR) clean -a
	$(REBAR) unlock

distclean: clean
	rm -rf $(BUILDDIR)

shell:
	$(REBAR) shell
	$(REBAR) unlock

ifeq (edit,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

edit:
	@scripts/create $(PROJECT)_$(RUN_ARGS) src/$(PROJECT)_$(RUN_ARGS).erl
	@$(EDITOR) src/$(PROJECT)_$(RUN_ARGS).erl

list:
	@ls src/$(PROJECT)_* | cut -d\_ -f2 | cut -d\. -f1

ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

build:
	@$(REBAR) escriptize
	@$(REBAR) unlock

run: build
	@$(BINPATHIN)/$(PROJECT) $(RUN_ARGS)

install:
	mkdir -p $(BINPATH)
	install -p $(BINPATHIN)/$(PROJECT) $(BINPATH)

uninstall:
	rm -f $(BINPATH)/$(PROJECT)
	rmdir -p --ignore-fail-on-non-empty $(BINPATH)
