# BeatStream — Flutter UI

A production-structured Flutter implementation of the BeatStream UI kit
(10 screens: Welcome, Login, Register, Home, Favorites, Now Playing,
Profile, Settings, Notifications, Privacy & Security).

## Stack

| Concern            | Choice                                            |
|---------------------|---------------------------------------------------|
| State management    | `flutter_bloc` (Cubit)                             |
| Navigation          | `go_router` (`StatefulShellRoute` for bottom nav)  |
| Data                | Repository-pattern mocks (see below)               |
| Typography          | `google_fonts` — Hanken Grotesk                    |
| Images              | `cached_network_image` (disk+memory caching)       |

## Getting started

This project's `lib/`, `pubspec.yaml`, `test/` and `analysis_options.yaml`
were generated outside of the Flutter SDK (no `flutter`/`dart` binary was
available in the authoring sandbox), so the platform folders
(`android/`, `ios/`, `web/`, etc.) aren't included yet. Generate them once,
locally:

```bash
# 1. Scaffold a fresh Flutter project (creates android/ios/web/pubspec.yaml/lib)
flutter create --org com.beatstream --project-name beatstream beatstream_scaffold

# 2. Copy this repo's pubspec.yaml, lib/, test/ and analysis_options.yaml
#    into that scaffold, overwriting the generated placeholders:
cp -r beatstream/pubspec.yaml beatstream/analysis_options.yaml \
      beatstream/lib beatstream/test \
      beatstream_scaffold/

cd beatstream_scaffold

# 3. Fetch packages
flutter pub get

# 4. Run
flutter run
```

Alternatively, if you already have an existing Flutter project shell, just
drop this repo's `lib/`, `pubspec.yaml`, `analysis_options.yaml` and `test/`
into it and run `flutter pub get`.

## Architecture

```
lib/
├── core/
│   ├── theme/       # Design tokens: colors, type scale, spacing, radius
│   ├── router/      # go_router configuration
│   ├── utils/       # Validators, Debouncer
│   └── widgets/      # Shared building blocks (buttons, text field, list tiles, cached image)
├── data/
│   ├── models/       # Song, Album, Artist, UserProfile, NotificationSetting
│   └── repositories/ # Abstract interfaces + Mock* implementations
└── features/
    ├── welcome / auth / home / favorites / now_playing /
    │   profile / settings / notifications / privacy_security / search
    │   each with cubit/ (state + Cubit) and view/ (widgets)
    └── shell/        # Bottom-nav shell, persistent mini-player
```

### Swapping mocks for a real backend

Every screen depends only on the abstract repository interfaces
(`MusicRepository`, `AuthRepository`, `UserRepository`) — never on the
`Mock*` classes directly. To go live:

1. Write `ApiMusicRepository implements MusicRepository` (etc.) backed by
   `http`/`dio` calls to your API.
2. Swap the `RepositoryProvider<T>.create` in `lib/main.dart` to construct
   your new class instead of the mock.

No Cubit or widget code needs to change.

## Performance notes

- **Lazy loading**: every list (trending songs, albums, artists, recently
  played, favorites, search results) uses `ListView.builder` /
  `GridView.builder` / `SliverList.builder`, so off-screen items are never
  built or laid out.
- **Image caching**: `AppNetworkImage` wraps `cached_network_image` with a
  capped `memCacheWidth`, so large remote art doesn't get decoded at full
  resolution just to be displayed at thumbnail size, and repeat scrolling
  doesn't re-fetch from the network.
- **Debounced search**: `SearchCubit` debounces keystrokes (`Debouncer`,
  300ms) and discards stale responses via a request-id guard, so typing
  quickly doesn't spam the repository or risk a slow older request
  clobbering a newer result.
- **Const constructors** throughout static widget subtrees, and
  `Equatable` states so `BlocBuilder`/`BlocSelector` skip rebuilds when
  nothing relevant changed.
- **Preserved tab state**: the bottom-nav shell uses
  `StatefulShellRoute.indexedStack`, so switching Home → Favorites → Home
  doesn't reset scroll position or re-fetch data.

## Input validation

`core/utils/validators.dart` centralizes all form rules (email format,
password strength, phone format, name format, confirm-password match).
`LoginCubit`/`RegisterCubit` validate on submit and expose per-field error
strings that the UI renders inline — see `AppTextField`.

## Tests

```bash
flutter test
```

Includes validator unit tests and a `bloc_test`-based `LoginCubit` test
demonstrating the mocking pattern (via `mocktail`) for repository-backed
Cubits.
