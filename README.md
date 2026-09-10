# Pokopay Merchant App

Flutter mobile app for Pokopay merchants. Merchants sign in, see their settled balance and recent payouts, browse settlement history, view sales reports by period, and manage their profile and password. Ships for Android and iOS.

The UI follows the Figma Make design "Pokopay Mobile" (warm off-white canvas, Montserrat headings, DM Sans body, borderless white cards, bottom navigation). The exported React reference lives outside this repo in `~/Downloads/Pokopay Mobile`; the merchant mobile screens are under `src/app/components/Merchant*Mobile.tsx`.

## Stack

| Concern | Choice |
|---|---|
| Framework | Flutter 3.41 (stable), Dart SDK ^3.11 |
| State | [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) 3 (`Notifier` / `FutureProvider`) |
| Navigation | [go_router](https://pub.dev/packages/go_router) with auth-aware redirects |
| HTTP | [dio](https://pub.dev/packages/dio) with a bearer-token interceptor |
| Models | [freezed](https://pub.dev/packages/freezed) + [json_serializable](https://pub.dev/packages/json_serializable) (generated code is checked in) |
| Secure storage | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) (Keychain / Keystore) |
| Biometrics | [local_auth](https://pub.dev/packages/local_auth) |
| UI | Material 3, [google_fonts](https://pub.dev/packages/google_fonts), [lucide_icons_flutter](https://pub.dev/packages/lucide_icons_flutter) |
| Formatting | [intl](https://pub.dev/packages/intl) (Naira currency, dates) |

## Getting started

Prerequisites: Flutter 3.41+ on the stable channel, Xcode for iOS, Android Studio / SDK for Android.

```bash
flutter pub get
flutter run
```

The app talks to `https://api.pokopayng.com` by default. Everything environment-specific is a compile-time define; there is no `.env` file.

| Define | Purpose | Default |
|---|---|---|
| `API_BASE_URL` | Backend base URL (staging, local, tunnel) | `https://api.pokopayng.com` |
| `SENTRY_DSN` | Enables crash reporting when set | empty (reporting off) |
| `APP_ENV` | Environment tag on Sentry events | `development` |
| `START_ROUTE` | Screen to open right after sign-in, for screenshots | empty (dashboard) |
| `DEV_LOGIN_EMAIL`, `DEV_LOGIN_PASSWORD` | Debug builds only: prefill and submit the login form | empty |

```bash
flutter run --dart-define=API_BASE_URL=https://staging.api.example.com \
            --dart-define=SENTRY_DSN=https://...@sentry.io/... \
            --dart-define=APP_ENV=staging
```

The same flags work with `flutter build`.

To open the app on a specific screen right after sign-in (handy for screenshots), pass `--dart-define=START_ROUTE=/wallet`.

## Everyday commands

```bash
# Static analysis (flutter_lints)
flutter analyze

# Tests (unit + widget)
flutter test

# Regenerate localizations after editing lib/l10n/app_en.arb
flutter gen-l10n

# Regenerate freezed / json_serializable code after editing a model
dart run build_runner build --delete-conflicting-outputs

# Regenerate launcher icons and native splash after changing assets/branding/
dart run flutter_launcher_icons
dart run flutter_native_splash:create

# Release builds
flutter build apk --release
flutter build appbundle --release
flutter build ipa --release
```

## Project layout

```
lib/
├── main.dart                     # Sentry init, ProviderScope, MaterialApp.router, AppGate
├── core/
│   ├── api/
│   │   ├── api_client.dart       # Dio setup, base URL, auth interceptor
│   │   └── models/               # freezed request/response models (+ generated *.g.dart / *.freezed.dart)
│   ├── biometric/                # local_auth wrapper
│   ├── cache/cache_store.dart    # JSON cache on shared_preferences for offline reads
│   ├── config/                   # AppConfig (remote), AppGate (force update / maintenance)
│   ├── connectivity/             # Offline status + connectivity stream
│   ├── router/app_router.dart    # Route table + auth redirect logic
│   ├── storage/secure_storage.dart
│   └── theme/                    # AppColors (design tokens), AppText (Montserrat / DM Sans), AppTheme
├── features/
│   ├── auth/                     # Login, change password, AuthController
│   ├── dashboard/                # Home screen: balance, latest payout, recent settlements
│   ├── merchant/                 # MerchantRepository + Riverpod providers for reports/settlements
│   ├── reports/                  # Sales report by period (daily/weekly/monthly)
│   ├── settlements/              # "Statements and Billing": settlement history + detail sheet
│   ├── settings/                 # Profile, business details, report preferences
│   ├── splash/
│   ├── stores/                   # Store profile + card machines (terminals)
│   └── wallet/                   # Balance card, next payout, payouts/fees history
├── l10n/
│   ├── app_en.arb                # All user-facing strings (source of truth)
│   └── generated/                # flutter gen-l10n output, git-ignored
└── shared/
    ├── format.dart               # MoneyFormat + formatMoney, formatDate, formatDayLabel, ...
    └── widgets/                  # See "Design system" below
test/
├── helpers/fakes.dart            # FakeAdapter (Dio), FakeSecureStorage
├── shared/, core/, features/     # Unit tests
└── widget/                       # Widget tests (login)
```

Each feature follows a light `data/` (repositories, talk to the API) and `presentation/` (screens, controllers, providers) split. Repositories are exposed as Riverpod providers and injected via `ref`.

## Routes

Defined in [app_router.dart](lib/core/router/app_router.dart) as `AppRoutes` constants.

| Path | Screen |
|---|---|
| `/` | Splash (shown while auth state is unknown) |
| `/login` | Login, with optional biometric sign-in |
| `/dashboard` | Home |
| `/reports` | Sales report |
| `/settlements` | Settlement history |
| `/wallet` | Wallet / balance |
| `/stores` | Store profile and card machines |
| `/settings` | Settings hub |
| `/settings/personal` | Personal info |
| `/settings/business` | Business details |
| `/settings/security/change-password` | Change password |

The router listens to `authControllerProvider`. Unauthenticated users are always sent to `/login`; authenticated users hitting `/` or `/login` are sent to `/dashboard`.

## Auth flow

1. On launch `AuthController` reads the access token from secure storage. If present it calls `GET /api/v1/auth/me` to hydrate the user; otherwise the state becomes `unauthenticated`.
2. Login posts to `POST /api/v1/auth/login`, stores the access (and optional refresh) token, then loads `/me`.
3. Merchant screens need a merchant ID (`mid`). If `/me` does not return one, the controller searches `GET /api/v1/merchants?search=<email>` and uses the matching record's `mid`. If that finds nothing (admin and CSA accounts), it falls back to the first merchant on the platform, and the account drawer shows a "Switch merchant" picker so those users can choose which business to view.
4. Every request carries `Authorization: Bearer <token>`. A `401` response clears stored tokens, which flips the router back to `/login`.
5. Logout calls `POST /api/v1/auth/logout` (errors ignored) and clears all stored tokens and biometric credentials.

**Biometric sign-in.** When the user opts in at login, the email and password are saved in platform secure storage. "Use Biometrics" prompts with `local_auth`, and on success replays a normal password login with the saved credentials. Note that this is credential replay, not a device-bound token; keep that in mind if the backend later offers refresh tokens or device keys.

## Operations

**Crash reporting.** Sentry, enabled only when `SENTRY_DSN` is passed at build time. Request bodies are stripped before sending and PII is off. Create a free Sentry project, copy its DSN, and pass it in your release build command.

**Force update and maintenance.** On launch the app fetches `GET /api/v1/app/config` (see the backend brief). If the installed version is below `minSupportedVersion` or `forceUpdate` is true, a blocking update screen replaces the app. If `maintenance.enabled` is true, a strip appears above every screen. Until the endpoint exists the app falls back to the last cached config, then to permissive defaults.

**Offline.** Every merchant read (summary, sales, settlements, terminals, profile) stores its last successful JSON in `CacheStore`. When the network is unreachable, the cached copy is served and an "Offline · showing data saved…" banner appears on the data screens. When connectivity returns, providers refetch automatically. Cache is cleared on logout.

**Localisation.** Strings live in `lib/l10n/app_en.arb`. To add a language, copy it to `app_<code>.arb`, translate, and run `flutter gen-l10n`. Currency symbol, code, and locale come from remote config (`currency`) via `MoneyFormat.configure`, defaulting to Naira.

**Accessibility.** Icon-only buttons carry semantic labels, touch targets are at least 44 pt, body text never drops below 12 pt, and tertiary text uses a grey that passes WCAG AA on white.

**CI.** `.github/workflows/ci.yml` runs analyze, tests, and a debug APK build on every push and PR, plus an unsigned iOS build on `main`.

**Store assets.** Listing copy, privacy policy, data-safety answers, and screenshots are in `store/`.

## Backend endpoints used

All paths are relative to `API_BASE_URL`.

| Method | Path | Used by |
|---|---|---|
| POST | `/api/v1/auth/login` | Login |
| GET | `/api/v1/auth/me` | Session bootstrap, profile |
| POST | `/api/v1/auth/change-password` | Change password |
| POST | `/api/v1/auth/logout` | Logout |
| GET | `/api/v1/merchants?search=&page=&size=` | Discover `mid` by email; merchant switcher for admins |
| GET | `/api/v1/merchants/mid/{mid}` | Business details |
| GET | `/api/v1/merchant/reports/summary?mid=` | Dashboard, wallet, settlements header |
| GET | `/api/v1/merchant/reports/sales?mid=&period=&startDate=&endDate=` | Reports |
| GET | `/api/v1/merchant/reports/settlements?mid=&page=&size=` | Settlement list |
| GET | `/api/v1/merchant/reports/settlements/{reference}` | Settlement detail |
| GET | `/api/v1/merchant/reports/terminals?mid=` | Terminal list |

Response shapes live in [auth_models.dart](lib/core/api/models/auth_models.dart) and [merchant_models.dart](lib/core/api/models/merchant_models.dart). In debug builds Dio logs request and response bodies to the console.

## Design system

Tokens live in [app_colors.dart](lib/core/theme/app_colors.dart) and [app_text.dart](lib/core/theme/app_text.dart). Use `AppText.display` for page titles and hero figures, `AppText.money` for amounts, `AppText.body` for everything else, and `AppText.label` for small uppercase captions.

Reusable pieces in `lib/shared/widgets/`:

| Widget | Purpose |
|---|---|
| `BackScaffold` | Page chrome: round white back button, oversized title, optional trailing action and bottom nav |
| `PokoBottomNav` | Home / Sales / Money / Settings bar; the active tab renders as a grey chip |
| `AppDrawer` | Account drawer opened from the dashboard hero pill |
| `ListCard`, `ListRow`, `InitialsTile`, `DirectionBadge` | White grouped lists with hairline dividers |
| `SurfaceCard` | Plain white rounded card |
| `PillTabs`, `PillChip`, `SegmentedControl`, `UnderlineTabs` | The three tab styles used across screens |
| `SectionLabel` | Caption above a list card |
| `InfoRow` | Label-over-value row for detail screens, optional copy button |
| `AsyncSlot` | Loading / error / data wrapper for a Riverpod `AsyncValue` |
| `EmptyState` | Centered icon + message card |
| `RoundIconButton` | Circular white icon button |
| `PokopayMark`, `PokopayLogo`, `PokopaySymbol` | Branding |

## Adding a new API-backed screen

1. Add or extend a freezed model in `lib/core/api/models/` and run `build_runner`.
2. Add a fetch method to the relevant repository (or create a new one under `features/<name>/data/`).
3. Expose the data as a `FutureProvider` in `features/<name>/presentation/`, reading `mid` from `authControllerProvider` as the existing merchant providers do.
4. Build the screen with `ConsumerWidget`, render the provider with `AsyncSlot` (handles loading / error / retry), and wrap in `BackScaffold`. Pass `bottomNav: PokoBottomNav(active: ...)` if it is a top-level tab.
5. Register the path in `AppRoutes` and the `GoRouter` route list.

## Branding assets

`assets/branding/` holds the logo, wordmark, launcher icon sources, and splash images. Icon and splash configuration is in [pubspec.yaml](pubspec.yaml) under `flutter_launcher_icons` and `flutter_native_splash`. Light splash is white, dark splash is `#0C2545`. After changing these images, re-run the two generator commands listed above.

## Platform notes

- **App ID / bundle ID:** `com.pokopay.pokopay` on both platforms.
- **Android:** requires `INTERNET`, `USE_BIOMETRIC`, `USE_FINGERPRINT`. Min/target SDK follow Flutter defaults.
- **iOS:** deployment target 13.0. `NSFaceIDUsageDescription` is set in `Info.plist`. Keychain items use `first_unlock` accessibility so tokens survive a device restart once unlocked.
- Linux, macOS, Windows, and web folders exist from the Flutter template but are not actively targeted.

## Known gaps

- Release signing is not set up (still in development). See `store/README.md`.
- Data-layer error messages (for example "Invalid email or password") are English-only; UI strings are localised.
- Export, payment links, "New sale", withdraw, preferences, and report recipients show a "Coming soon" or informational message; there are no backend endpoints for them yet.
- Wallet fee rows are derived from each settlement's `settlementFee`; there is no separate fee ledger endpoint.
- Report e-mail toggles on the Settings screen are stored locally with `shared_preferences` and are not yet synced to the backend.
- The remote config, transactions, wallet, and other endpoints in the backend brief do not exist yet; the app degrades gracefully without them.
- Refresh tokens are stored but not yet used to renew an expired session; a `401` simply logs the user out.
