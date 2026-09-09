# Store assets

Everything needed for the App Store and Google Play listings, kept next to the code so it ships with each release.

| File | Use |
|---|---|
| `listing.md` | App name, subtitle, descriptions, keywords, category, contact details for both stores |
| `privacy-policy.md` | Privacy policy. Host it at a public URL (e.g. pokopayng.com/privacy) and paste that URL into both store consoles |
| `data-safety.md` | Answers for Google Play Data safety and Apple App Privacy questionnaires |
| `screenshots/ios/` | 1170 × 2532 captures from an iPhone 16e simulator (accepted for the 6.1" slot). Regenerate with `flutter run --dart-define=START_ROUTE=/wallet` etc. and `xcrun simctl io booted screenshot` |
| `screenshots/android/` | Add 1080 × 2400 captures from a Pixel emulator when Android screenshots are needed |

Still needed before submission (see the "Release signing" item in the roadmap):

- Android upload keystore and `android/key.properties`
- Apple Developer team on the Xcode project, App Store Connect record
- Feature graphic 1024 × 500 for Google Play
- App icon 1024 × 1024 without alpha for App Store Connect (`assets/branding/app_icon_ios.png` is the source)
