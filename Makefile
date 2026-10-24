# Local builds. The version comes from git (see build.rs):
#   tag v0.0.1 checked out       -> 0.0.1
#   8 commits past v0.0.1        -> 0.0.1+8.g0587d41
#   uncommitted changes          -> ...+dirty
# Release builds set REACTION_TIME_TEST_VERSION explicitly, so they keep the plain release version.

PREFIX ?= /usr/local
BIN := target/release/reaction-time-test

.PHONY: all build install uninstall version clean

all: build

build:
	cargo build --release

install: build
	install -Dm755 $(BIN) $(DESTDIR)$(PREFIX)/bin/reaction-time-test
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/reaction-time-test/LICENSE

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/reaction-time-test
	rm -f $(DESTDIR)$(PREFIX)/share/licenses/reaction-time-test/LICENSE

version:
	@cargo clean -q -p reaction-time-test --release && cargo build --release -vv 2>&1 | sed -n 's/^.*cargo:rustc-env=REACTION_TIME_TEST_VERSION=//p' | tail -n 1

clean:
	cargo clean
