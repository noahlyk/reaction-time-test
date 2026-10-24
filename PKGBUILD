# Maintainer: fibsussy <noahlykins@gmail.com>
pkgname=reaction-time-test
pkgver=0.0.1
pkgrel=1
pkgdesc="A CLI/TUI reaction time test inspired by Human Benchmark"
arch=('x86_64' 'aarch64')
url="https://github.com/fibsussy/reaction-time-test"
license=('MIT')
makedepends=('cargo')
options=('!debug')

# Local builds from a git checkout report the tag, commit count and hash, the same as `make`:
#   0.0.1+2.gbbd181e, or 0.0.1+2.gbbd181e.dirty with uncommitted changes.
# Anywhere without git (or on the release tag) the version above is used.
pkgver() {
    cd "$startdir"
    git rev-parse --git-dir >/dev/null 2>&1 || { echo "$pkgver"; return; }

    local version meta=() described dirty
    if described=$(git describe --tags --long --match 'v[0-9]*' 2>/dev/null); then
        local rest="${described%-g*}"
        version="${rest%-*}"
        version="${version#v}"
        local count="${rest##*-}"
        (( count > 0 )) && meta+=("$count.g${described##*-g}")
    else
        version="0.0.0"
        meta+=("g$(git rev-parse --short HEAD)")
    fi
    [ -n "$(git status --porcelain --untracked-files=no)" ] && meta+=(dirty)

    if (( ${#meta[@]} )); then
        local IFS=.
        version+="+${meta[*]}"
    fi
    echo "$version"
}

build() {
    cd "$startdir"
    REACTION_TIME_TEST_VERSION="$pkgver" cargo build --release
}

package() {
    cd "$startdir"

    install -Dm755 target/release/reaction-time-test "$pkgdir/usr/bin/reaction-time-test"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
