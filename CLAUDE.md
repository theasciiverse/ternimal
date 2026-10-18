# ternimal (Asciiverse packaging)

Philipp Emanuel Weidmann's Ternimal, a lifeform that creeps around the
terminal in half blocks; one Rust file, no crates, no Cargo; GPL-3.0-only;
packaged for the Asciiverse catalog as a demo (kind `art`). Not our code:
keep changes small, list every one in PATCHES.md, and offer fixes upstream.

- Remotes: `upstream` is github.com/p-e-w/ternimal (branch `master`, quiet
  since 2017), `origin` is github.com/theasciiverse/ternimal.
- Branch `asciiverse` = upstream master plus our commits.
- Release: tag `v<version>-av.<n>` (now `v0.1.0+20171231-av.1`) and push
  only that tag; the workflow runs on `*-av.*` tags.
- av starts it as `ternimal fit=true`.
- Build: `rustc -O ternimal.rs -o out/ternimal`. Static, in a copy of the
  tree: `docker run --rm --cpus 4 --memory 8g -v "$PWD":/src -w /src
  rust:1-alpine rustc -O -C strip=symbols ternimal.rs -o out/ternimal`.
- Preview: `asciiverse/record-preview.sh out/ternimal asciiverse/ternimal.cast`.
