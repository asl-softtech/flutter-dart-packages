# ASL SoftTech — Flutter & Dart Packages

This monorepo hosts the open-source **Flutter and Dart packages** maintained by ASL SoftTech. Each package lives in its own directory with an independent `pubspec.yaml`, and is developed to be published separately on [pub.dev](https://pub.dev). Per-package documentation, changelogs, and examples live inside each package folder.

## Repository Layout

```
.
├── g_sync/        # Offline-first, mass data synchronization (MDT) package
└── k_widgets/     # Reusable Flutter widget collection
```

## Projects at a Glance

| Project | Purpose | Version | Level | Status |
| ------- | ------- | ------- | ----- | ------ |
| [g_sync](g_sync/) | Offline-first mass data sync with Hive, network requests, and file handling | 0.0.3 | **Level 3** — Release-ready | Active; changelog & example app in place |
| [k_widgets](k_widgets/) | Reusable form/selection widgets and field helpers for Flutter | 0.0.1 | **Level 1** — In development | Early; public API still being defined |

## Project Maturity Levels

Every project is rated on the same scale so it is easy to tell how safe it is to adopt:

- **Level 1 — In development.** Core code exists but the public API, docs, or examples are not finalized. Not recommended for production.
- **Level 2 — Candidate.** Code is stable and tested; documentation, changelog, and example coverage are in place. Ready for review and first release.
- **Level 3 — Release-ready.** Ready for (or already on) pub.dev: versioned, documented, with tests, license, and changelog.

---

## Project Guidelines

### g_sync

> **Which project?** Use `g_sync` when your app must keep a large dataset usable offline and sync it with a REST backend in bulk (download/upload with file support).

**Overview** — A Mass Data Transaction (MDT) package for Flutter/Dart. `g_sync` provides an offline-first synchronization layer built on `hive_ce`, supporting complex data syncing, file handling, and GET/POST/PUT/DELETE network requests through a single entry point (`GomuGomuSync`).

**Status & level** — `0.0.3`, **Level 3**. The most mature package in this repo: it ships a license, a maintained changelog, unit tests, and a runnable example app (with iOS platform support).

**Guidelines for this package**

- Local development & verification (run inside `g_sync/`):

  ```bash
  flutter pub get
  flutter analyze
  flutter test
  ```

- Run the example app: `cd g_sync/example && flutter run`.
- For each release: add a `CHANGELOG.md` entry, bump `version` in `pubspec.yaml`, then publish from the package directory (e.g. `flutter pub publish --dry-run` first).
- Read the full usage guide in [g_sync/README.md](g_sync/README.md).

**Roadmap** — Continue hardening network error handling and logging (recent releases), expand test coverage, and keep the example app in sync with the API.

---

### k_widgets

> **Which project?** Use `k_widgets` when you need ready-made Flutter widgets for common input patterns — date/time selection, dropdowns, search, radio fields, tables, location, and image picking — instead of building them by hand.

**Overview** — A Flutter widget package (`A Widget Package For Flutter`) collecting reusable UI components. It currently includes selection fields (date, datetime, time), dropdown, text input, search, radio fields, image selection / multi-image selectors, location input, tables, and column sections, plus supporting field-type and country data objects.

**Status & level** — `0.0.1`, **Level 1**. Early development: the package README is still a placeholder, there is no example app yet, and the public API surface (`lib/k_widgets.dart`) is still being defined, so the package is not yet ready to import from pub.dev.

**Guidelines for this package**

- Local development & verification (run inside `k_widgets/`):

  ```bash
  flutter pub get
  flutter analyze
  flutter test
  ```

- Keep widgets framework-agnostic where possible and follow existing naming/file conventions under `lib/src/widgets` and `lib/src/objects`.
- Before the first release to pub.dev, the package still needs to:
  1. Replace the placeholder package README with real docs and usage examples.
  2. Add an `/example` app demonstrating the widgets.
  3. Finalize the public API by filling in the barrel export (`lib/k_widgets.dart`).
  4. Add a proper `CHANGELOG.md` entry and set a `homepage`/`repository` in `pubspec.yaml`.

**Roadmap** — Move from Level 1 to Level 3 by completing the checklist above, then publish `0.0.1` to pub.dev.

---

## Contributing

- Both packages are standalone Flutter packages; develop and test each one from its own directory (never from the repo root).
- Run `dart format` and `flutter analyze` before opening a pull request; keep existing tests green.
- Prefer editing existing files and following each package's established structure over introducing new patterns.
- Issues and PRs are welcome on the [repository](https://github.com/asl-softtech/flutter-dart-packages).
- **License:** Each package is MIT-licensed; see the `LICENSE` file inside the respective package.
