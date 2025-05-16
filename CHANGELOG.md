# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/).

---

## [0.0.1] - 2025-05-16

### Added

- Initial release of `AutoWrapEllipsisText`.
- Supports dynamic pixel-based line wrapping.
- Automatically truncates overflowing text with ellipsis.
- Fully customizable via `TextStyle`, `maxLines`, `textAlign`, etc.
- Supports accessibility with `semanticsLabel`, locale, selectionColor.
- Gracefully handles size constraints (`SizedBox.shrink()` if not renderable).
- Optimized for rebuilds with internal width caching.

### Fixed

- Avoids crashes when `fontSize` or `height` is null by defaulting to `DefaultTextStyle`.

---

## [Unreleased]

- Support for multi-directional text (RTL refinement).
- Unit tests for edge-case behavior and render accuracy.
- Dart/Flutter 4.0 migration and null-safety strengthening.
