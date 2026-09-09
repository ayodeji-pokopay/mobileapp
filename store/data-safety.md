# Data safety and App Privacy answers

Use these answers for the Google Play **Data safety** form and the App Store Connect **App Privacy** questionnaire. They reflect what the app actually does as of v1.0.0; update them if you add analytics, ads, or new data types.

## Google Play — Data safety

**Does your app collect or share any of the required user data types?** Yes

**Is all of the user data collected by your app encrypted in transit?** Yes

**Do you provide a way for users to request that their data is deleted?** Yes — by email to support@pokopayng.com (link to the privacy policy)

| Data type | Collected | Shared | Ephemeral | Required | Purpose |
|---|---|---|---|---|---|
| Personal info › Email address | Yes | No | No | Yes | Account management, app functionality |
| Personal info › Name | Yes | No | No | Yes | App functionality (business/contact name) |
| Personal info › Phone number | Yes | No | No | No | App functionality (business contact) |
| Personal info › Address | Yes | No | No | No | App functionality (business address) |
| Financial info › Other financial info | Yes | No | No | Yes | App functionality (sales, settlements, masked payout account) |
| Financial info › Payment info | No | — | — | — | Card numbers are never shown or stored |
| App activity › App interactions | No | — | — | — | No analytics SDK |
| App info and performance › Crash logs | Yes | Yes (Sentry, service provider) | No | No | Analytics (crash diagnostics) |
| App info and performance › Diagnostics | Yes | Yes (Sentry) | No | No | Analytics (crash diagnostics) |
| Device or other IDs | No | — | — | — | No advertising ID; Sentry uses a random install ID only |
| Location | No | — | — | — | — |

**Security practices:** Data is encrypted in transit; users can request deletion; no independent security review claimed.

## Apple — App Privacy

**Data types collected:**

| Category | Data | Linked to user | Used for tracking | Purpose |
|---|---|---|---|---|
| Contact Info | Email Address | Yes | No | App Functionality |
| Contact Info | Name | Yes | No | App Functionality |
| Contact Info | Phone Number | Yes | No | App Functionality |
| Contact Info | Physical Address | Yes | No | App Functionality |
| Financial Info | Other Financial Info | Yes | No | App Functionality |
| Diagnostics | Crash Data | No | No | App Functionality |
| Diagnostics | Performance Data | No | No | App Functionality |

**Tracking:** No. The app does not track users across apps or websites and does not use the advertising identifier.

**Face ID usage string (already in Info.plist):** "Use Face ID to sign in to Pokopay securely."

## Notes for reviewers

- Demo account for review: provide a merchant login with sample settlements in the review notes.
- Biometric sign-in is optional and off by default.
- The app requires an existing Pokopay merchant account; there is no in-app sign-up.
