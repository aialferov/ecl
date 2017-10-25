PROJECT = ecl

REBAR := ./rebar3

BUILDDIR := _build

all:
	$(REBAR) escriptize
	$(REBAR) unlock

build:
	$(REBAR) compile
	$(REBAR) unlock

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
