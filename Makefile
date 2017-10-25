PROJECT = ecl

REBAR = ./rebar3

BUILDDIR = _build

export QUIET = 1

all:
	$(REBAR) escriptize
	$(REBAR) unlock

build:
	@$(REBAR) escriptize
	@$(REBAR) unlock

clean:
	$(REBAR) clean -a
	$(REBAR) unlock

distclean: clean
	rm -rf $(BUILDDIR)

upgrade:
	$(REBAR) upgrade
	$(REBAR) unlock

shell:
	$(REBAR) shell
	$(REBAR) unlock

ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

run: build
	@_build/default/bin/ecl $(RUN_ARGS)
