#!/bin/sh
# Packs out/ternimal into dist/ternimal-<target>.tar.gz (.zip for Windows)
# for av: the binary at the top beside README, LICENSE and PATCHES.md.
#
#   asciiverse/package.sh x86_64-unknown-linux-musl
set -eu
cd "$(dirname "$0")/.."
target="$1"
case "$target" in *windows*) exe=.exe ;; *) exe= ;; esac
stage=stage/ternimal
rm -rf "$stage" && mkdir -p "$stage" dist
cp "out/ternimal$exe" README.md LICENSE.txt PATCHES.md "$stage/"
if [ -n "$exe" ]; then
  (cd "$stage" && 7z a -tzip "../../dist/ternimal-$target.zip" . >/dev/null)
else
  tar -czf "dist/ternimal-$target.tar.gz" -C "$stage" .
fi
ls dist
