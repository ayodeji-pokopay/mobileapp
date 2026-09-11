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
| `DEV_MID` | Debug builds only: pin platform users (no merchant of their own) to this merchant | empty |

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
│   ├── notifications/            # Notification feed
│   ├── reports/                  # Sales overview, transactions, receipts, PDF export
│   ├── settlements/              # Settlements: payout history + detail sheet
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
| `/settlements` | Settlements (payout history) |
| `/wallet` | Wallet / balance |
| `/stores` | My business: profile and POS terminals |
| `/settings` | Settings hub |
| `/settings/personal` | Personal info |
| `/settings/business` | Business details |
| `/settings/security` | Security: password, biometric sign-in, app lock, signed-in devices |
| `/settings/security/change-password` | Change password |
| `/settings/sessions` | Signed-in devices, with per-device sign-out |
| `/insights` | Busiest hours and days, average sale, approval rate, week-on-week |

The router listens to `authControllerProvider`. Unauthenticated users are always sent to `/login`; authenticated users hitting `/` or `/login` are sent to `/dashboard`.

## Auth flow

1. On launch `AuthController` reads the access token from secure storage. If present it calls `GET /api/v1/auth/me` to hydrate the user; otherwise the state becomes `unauthenticated`.
2. Login posts to `POST /api/v1/auth/login`, stores the access (and optional refresh) token, then loads `/me`.
3. Merchant screens need a merchant ID (`mid`). If `/me` does not return one, the controller searches `GET /api/v1/merchants?search=<email>` and uses the matching record's `mid`. If that finds nothing (admin and CSA accounts), it falls back to the first merchant on the platform, and the account drawer shows a "Switch merchant" picker so those users can choose which business to view. The backend forces `mid` to the signed-in merchant for MERCHANT logins, so the app always sends it and never treats it as a security boundary.
4. Every request carries `Authorization: Bearer <token>`. The `AuthInterceptor` in [api_client.dart](lib/core/api/api_client.dart) refreshes the token via `POST /auth/refresh` shortly before it expires, and retries a request once after a `401`. When the refresh token itself is rejected the session is cleared, `SessionEvents` fires, and the router returns to `/login` with a "session expired" notice. A refresh that fails because the device is offline does not sign the user out.
5. Logout revokes the device enrolment, calls `POST /api/v1/auth/logout` (errors ignored), and clears tokens and the offline cache.

**Wallet amounts.** `GET /wallets/mid/{mid}` returns balances in kobo while every other endpoint uses naira. `WalletResponse.availableNaira` and `pendingNaira` divide by 100; flip `WalletResponse.balancesInMinorUnits` once the backend aligns it.

**PDFs.** The sales report and receipts are generated on the device with the `pdf` package (`lib/shared/pdf/pokopay_pdf.dart`) using the Pokopay logo, navy and green, and embedded Montserrat and DM Sans subsets from `assets/fonts/`. The backend's `/reports/sales/pdf` is no longer used for the export. Montserrat provides the ₦ glyph as a fallback for DM Sans.

**Biometric sign-in.** No password is stored. Ticking "Enable biometric sign-in" after a password login calls `POST /auth/devices` and keeps the returned device token in the Keychain or Keystore. Signing out keeps the enrolment so the merchant can come back with Face ID; the Settings toggle "Biometric sign-in" enrols or revokes the device explicitly. "Continue with biometrics" runs the OS prompt, then exchanges the device token via `POST /auth/devices/login`. A `401` there clears the token and asks the user to sign in with their password and re-enrol.

**Standard errors.** `/merchant/**` and app endpoints return `{ status, code, message, fieldErrors[] }`. `ApiError.from` parses it (and tolerates the legacy `/auth/*` shape), and `describeError` maps each `code` to localised copy. Validation errors surface field messages inline, for example on the report recipients sheet.

## Operations

**Crash reporting.** Sentry, enabled only when `SENTRY_DSN` is passed at build time. Request bodies are stripped before sending and PII is off. Create a free Sentry project, copy its DSN, and pass it in your release build command.

**Force update and maintenance.** On launch the app fetches `GET /api/v1/app/config` (see the backend brief). If the installed version is below `minSupportedVersion` or `forceUpdate` is true, a blocking update screen replaces the app. If `maintenance.enabled` is true, a strip appears above every screen. Until the endpoint exists the app falls back to the last cached config, then to permissive defaults.

**Offline.** Every merchant read (summary, sales, settlements, terminals, profile) stores its last successful JSON in `CacheStore`. When the network is unreachable, the cached copy is served and an "Offline · showing data saved…" banner appears on the data screens. When connectivity returns, providers refetch automatically. Cache is cleared on logout.

**Localisation.** Strings live in `lib/l10n/app_en.arb`, with full translations in `app_yo.arb` (Yoruba), `app_ha.arb` (Hausa), `app_ig.arb` (Igbo), and `app_pcm.arb` (Nigerian Pidgin). The language follows the phone by default and can be forced from Settings › Preferences (`localeProvider`). Flutter ships no Material strings for these four languages, so `FallbackMaterialLocalizationsDelegate` and friends in `lib/core/l10n/` serve English for date pickers and system dialogs. The Nigerian translations were machine-drafted and should be reviewed by native speakers. Currency symbol, code, and locale come from remote config (`currency`) via `MoneyFormat.configure`, defaulting to Naira.

**Dark mode.** `AppColors` is a set of getters over a `Palette` (light or dark). `AppTheme.build(dark:)` applies the palette and builds the `ThemeData`; the app root is re-keyed on every switch so all widgets rebuild. Appearance is chosen in Settings › Preferences (`themeModeProvider`: system, light, dark) and persisted. Because the palette is read at build time, never put an `AppColors` getter inside a `const` widget; use the `brandNavy` / `brandGreen` constants when a compile-time colour is genuinely needed.

**Lists.** Transactions and settlements page through `TransactionsList` / `SettlementsList` (`AsyncNotifier` families keyed by filter) with `loadMore()` triggered near the end of the scroll, and a `DateWindowChips` control offering 7/30/90-day presets or a custom range from the Material date-range picker.

**Password reset.** Login › "Forgot?" requests `POST /auth/forgot-password`; the user pastes the code (or the whole link) from the email, which the app verifies with `POST /auth/verify-reset-token?token=` before `POST /auth/reset-password`.

**App lock.** `lib/core/lock/` holds `AppLockController` (a `Notifier` that is also a `WidgetsBindingObserver`) and `LockScreen`. When enabled from Settings › Security, the app covers its content whenever it leaves the foreground and, after the chosen timeout (right away, 1, 5 or 15 minutes), demands Face ID / fingerprint or a 4-digit PIN. The PIN is stored only as a salted SHA-256 hash in secure storage; five wrong PINs sign the user out. The overlay is mounted from the `MaterialApp.builder` in `main.dart`, so it sits above every route.

**Insights.** `insightsProvider(days)` calls the backend's reporting endpoints in parallel (`summary-comparison`, `weekday`, `hourly`, `by-terminal`, `timeseries`, all bucketed in Africa/Lagos) and maps them with `InsightsStats.fromReports`. If those endpoints are unreachable on an older backend it falls back to `InsightsStats.compute`, which sums the raw transaction window on the phone. A null previous-period change is shown as "New", never as +100%.

**Push notifications.** Firebase project `pokopay-2d7af`; client identifiers live in `lib/firebase_options.dart` (no native config files needed). `PushService` requests permission, fetches the FCM token and registers it with `POST /devices/push` (`{mid, platform, token, deviceId, appVersion}`) whenever a merchant is signed in and the push preference is on; it deletes the registration on sign-out or when push is turned off. A push received in the foreground shows a banner (Android via `flutter_local_notifications` on the `pokopay_alerts` channel; iOS via FCM's foreground presentation options) and refreshes the bell. Tapping a push from any state routes by its `data.type`: settlement types open Settlements › History, everything else opens the feed (`pushRouteFor`). Sign-out also deletes the FCM token so the next sign-in gets a fresh one. iOS needs the APNs auth key uploaded in Firebase › Cloud Messaging and the `aps-environment` entitlement (already in `Runner.entitlements`); `AppDelegate.swift` calls `registerForRemoteNotifications()` at launch explicitly, because on iOS 26 the Firebase app-delegate proxy alone never produced an APNs token, and logs the APNs result so `flutter run` shows it. The backend's Admin SDK service-account key is kept outside the repo at `~/.pokopay/firebase-service-account.json`.

**Home dashboard (phase 3).** `dashboard_providers.dart` and `dashboard_widgets.dart` hold the pieces: a three-step settlement tracker driven by `todaySettlement.status`; a terminal health strip (online ≤10 min, idle ≤24 h, offline) from `lastHeartbeat`; an approval-rate warning when today's rate is 15 points under the 30-day norm with the most common decline reason; "vs last {weekday}" from the timeseries endpoint with "vs yesterday" as fallback; quick actions (send / print last receipt, payment link behind its flag, call support from config); client-side daily and monthly sales targets with a progress ring on the hero; and activity filter chips. Users lacking `VIEW_SETTLEMENTS` get a cashier view: takings instead of balance, no wallet/settlement screens (also enforced by the router), and no company preferences without `MANAGE_PREFERENCES`.

**Device integrity.** `deviceIntegrityProvider` (safe_device) flags rooted/jailbroken phones and emulators. A warning banner shows on Home; when remote config sets `security.blockCompromisedDevices` the `AppGate` refuses to run instead. Push registration is skipped on emulators. The app lock is on by default with a 15-minute timeout (`security.lockTimeoutMinutes` can change the default); Home prompts once to add a PIN so the lock still works without biometrics.

**Suspicious-activity alerts.** Notifications with `type = SUSPICIOUS_ACTIVITY` carry `severity`, `rule`, `evidence` and `acknowledged`. Unreviewed ones appear first in the feed as alert cards with "Mark as reviewed" (`POST /merchant/notifications/{id}/acknowledge`, which also re-arms detection for that terminal and rule) and as a red banner on Home. Known rule: `REVERSAL_BURST`.

**Receipts to customers.** The receipt sheet offers "Send to customer": WhatsApp (`wa.me`), SMS (`sms:`), clipboard, or a paired ESC/POS Bluetooth thermal printer (`lib/core/printing/receipt_printer.dart`, 58 or 80 mm, set up under Settings › Receipt printer). Thermal fonts rarely include ₦, so printed receipts say `NGN`.

**Signed-in devices.** Settings › Security › Signed-in devices lists `GET /users/me/sessions`, revokes one with `DELETE /users/me/sessions/{tokenId}` and everything else with `POST /users/me/sessions/revoke-others`. Every request carries `X-Device-Id` (stable per install) and `X-Device-Name` so the backend can label sessions once it reads them.

**Card machine names.** Tapping a terminal under My business opens a rename sheet backed by `PUT /merchant/terminals/{id}`. Until the backend ships that endpoint (it currently returns 500) the sheet shows a friendly "not available yet" message.

**Accessibility.** Icon-only buttons carry semantic labels, touch targets are at least 44 pt, body text never drops below 12 pt, and tertiary text uses a grey that passes WCAG AA on white.

**CI.** `.github/workflows/ci.yml` runs analyze, tests, and a debug APK build on every push and PR, plus an unsigned iOS build on `main`.

**Store assets.** Listing copy, privacy policy, data-safety answers, and screenshots are in `store/`.

## Security posture

The app never sees full card numbers: the backend returns `panMasked` only, and that is all the app displays, prints, or puts in a receipt. Access and refresh tokens live in the platform keychain / keystore (`flutter_secure_storage`, iOS accessibility `first_unlock_this_device` so they never sync via iCloud Keychain); passwords are never stored. All traffic is HTTPS: iOS App Transport Security is left at its defaults, and Android ships a network security config that forbids cleartext and trusts only system CAs. Android backups and device-to-device transfer are disabled (`allowBackup=false`, `data_extraction_rules.xml`). The debug-only Dio logger prints no bodies or headers; Sentry sends no request data or PII. Sign-in errors are mapped from codes to localised copy, so backend messages are never echoed verbatim to users. App lock (biometric or PIN, 5 attempts) covers the app in the switcher and re-authenticates after a timeout.

Not yet done, and worth deciding before store release: certificate pinning (needs a rotation plan with the backend), blocking screenshots (`FLAG_SECURE`) on financial screens, encrypting the offline cache (it holds masked PANs and amounts in shared preferences), and a real release keystore for Android (still signed with the debug key).

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
| POST | `/api/v1/auth/refresh` | Silent token refresh |
| POST / DELETE | `/api/v1/auth/devices`, `/auth/devices/login`, `/auth/devices/{id}` | Biometric enrol, sign-in, revoke |
| GET | `/api/v1/app/config?platform=&version=` | Force update, maintenance, feature flags, currency |
| GET | `/api/v1/wallets/mid/{mid}` | Dashboard balance, Wallet, next payout, settlement account |
| GET | `/api/v1/merchant/reports/summary?mid=` | Dashboard tiles (today vs yesterday, today's settlement) |
| GET | `/api/v1/merchant/reports/sales?mid=&period=&compare=true` | Sales overview, previous-period delta, channels, refunds |
| GET | `/api/v1/merchant/transactions?mid=&status=&last4=&startDate=&endDate=&page=&size=` | Sales › Transactions, dashboard activity and sparkline, sales chart (the report has no daily breakdown, so days are summed client-side). Dates are required; without them the backend returns today only |
| GET | `/api/v1/merchant/transactions/{reference}?mid=` | Receipt sheet |
| GET | `/api/v1/merchant/reports/settlements?mid=&status=&page=&size=` | Settlements › History |
| GET | `/api/v1/merchant/statements?mid=&year=` and `/{id}/pdf` | Settlements › Statements, PDF download |
| GET | `/api/v1/merchant/terminals?mid=` | My business › POS terminals, drawer count |
| PUT | `/api/v1/merchant/terminals/{id}?mid=` | Rename a card machine (backend pending; 5xx shows "not available yet") |
| GET | `/api/v1/merchant/reports/transactions/summary-comparison`, `weekday`, `hourly`, `by-terminal`, `timeseries` | Insights (Lagos-time buckets; client fallback if absent) |
| POST | `/api/v1/merchant/notifications/{id}/acknowledge` | Mark a suspicious-activity alert reviewed |
| POST / DELETE | `/api/v1/devices/push`, `/api/v1/devices/push/{deviceId}?mid=` | FCM token registration and removal |
| GET | `/api/v1/users/me/sessions` | Settings › Security › Signed-in devices |
| DELETE | `/api/v1/users/me/sessions/{tokenId}` | Sign out one device |
| POST | `/api/v1/users/me/sessions/revoke-others` | Sign out all other devices |
| GET / PUT | `/api/v1/merchant/preferences?mid=` | Settings toggles and report recipients |
| GET / POST | `/api/v1/merchant/notifications?mid=`, `/read-all` | Notifications screen, bell badge |

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
- Payment links and invoices are hidden behind `features.paymentLinks` / `features.invoices` from remote config.
- Refunds and chargebacks come back as zeros from the backend for now, so that card is hidden until either is non-zero.
- Terminal renaming, staff roles and server-side insights wait on backend endpoints (see the Phase 2 brief); the app degrades gracefully in the meantime.
- Bluetooth printing needs a real device; the simulator reports no paired printers.
