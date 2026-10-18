# Changes from upstream

This is the Asciiverse packaging of [Ternimal](https://github.com/p-e-w/ternimal)
by Philipp Emanuel Weidmann, a lifeform that creeps around the terminal,
drawn in half blocks (one Rust file, no crates). Upstream is the `upstream`
remote; the `asciiverse` branch carries the changes below.

Built from upstream `master` at `e7953b4` (2017-12-31), two commits after
the v0.1.0 tag (a faster renderer, and a spine built from arcs). Upstream
has not changed since, so the version here is 0.1.0+20171231.

## Licence

GPL-3.0-only. The source header and the README say "the GNU General Public
License, version 3" and LICENSE.txt is the GPL version 3 text; nothing
offers "any later version" (checked 2026-10-18).

## Code

- **Any key quits, and so do Ctrl+C, SIGTERM and SIGHUP.** Upstream had no
  input at all and ran until killed, which left the terminal wherever the
  last frame put it. A small `term` module at the end of `ternimal.rs`,
  still with the standard library only, reads keys on a background thread
  with echo and line editing off (termios through `tcgetattr` and
  `tcsetattr` on Linux and macOS, console modes on Windows, where escape
  sequences are also switched on for the output). Ctrl+C arrives as a key;
  the signals set the same flag. On the way out the colours, the cursor and
  the terminal settings are put back, also when an argument error exits.
  At the end of input (stdin not a terminal) it keeps running, as before.
- **`fit=true` fills the terminal.** Upstream draws a fixed arena (60 by
  40 blocks, 60 columns by 20 lines) below the cursor. With `fit=true` the
  arena is the whole window, drawn on the alternate screen with the cursor
  hidden, and it starts again at the new size whenever the window is
  resized. When the window is too small for the path (below about 60x20
  with the default shape), it says so and waits for a resize or a key
  instead of exiting. `width` and `height` are ignored in this mode; every
  other argument works as before. Without `fit=true` it behaves as
  upstream, except for the quitting above.

## Packaging

- `asciiverse/package.sh` packs one target for av: the binary, README,
  LICENSE.txt and this file.
- `.github/workflows/release.yml`: av archives for Linux (static musl,
  x86-64 and ARM64, built with rustc in Alpine), macOS (x86-64 and ARM64)
  and Windows (x86-64 and ARM64, MSVC), plus SHA256SUMS. Runs on our tags
  only (`*-av.*`).
- `asciiverse/record-preview.sh` records `asciiverse/ternimal.cast`, the
  catalog preview: 25 seconds of `ternimal fit=true seed=7` at 100x30,
  ended by SIGTERM.

av starts it as `ternimal fit=true`.

## Checked

- Linux, static musl build (rustc 1.99.0 in Alpine), in tmux at 100x30:
  any key, q, Ctrl+C and SIGTERM quit with exit status 0 and the terminal
  settings back as they were (echo and line editing on); without
  `fit=true`, q quits and the drawing stays above the prompt; resizing to
  60x20 redraws at the new size, 30x10 shows the too-small message, and
  120x40 draws again.
- Windows and macOS: type-checked with rustc for x86_64-pc-windows-gnu and
  aarch64-apple-darwin; not run.
