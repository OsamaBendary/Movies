# 🎬 Movies App

A feature-rich Flutter movie discovery app powered by the [YTS API](https://yts.mx/api), with Firebase authentication, a polished dark UI, and smooth navigation.

---

## 📱 Screenshots & Flow

```
Splash → Onboarding → Auth (Login / Register) → Home → Movie Details
```

---

## ✨ Features

- **Authentication** — Email/password login & registration, Google Sign-In, and password reset via Firebase Auth
- **Onboarding** — Multi-page intro flow with SharedPreferences to track first-time users
- **Movie Discovery** — Fetches live movie data from the YTS API using Dio
- **Movie Details** — Full detail view with cover image, screenshots, cast, summary, rating, runtime, and like count
- **Similar Movies** — Grid of suggested movies fetched per movie
- **Profile Screen** — Displays Firebase user info (avatar, display name), with an edit screen and sign-out
- **Bottom Navigation** — Floating nav bar with Home, Search, Browse, and Profile tabs
- **Custom Theming** — Consistent dark theme using a centralized `AppColors` palette

---

## 🗂️ Project Structure

```
lib/
├── core/
│   ├── apis/
│   │   └── api manager/
│   │       └── api_manager.dart        # Dio API calls (list, details, suggestions)
│   ├── models/
│   │   ├── api_result.dart             # Top-level API response wrapper
│   │   ├── movie.dart                  # Movie list item model
│   │   ├── movie_details.dart          # Full movie detail model (with Cast)
│   │   └── torrent.dart                # Torrent info model
│   ├── routes/
│   │   ├── app_routes.dart             # Centralized route generation
│   │   └── route_names.dart            # Route name constants
│   ├── services/
│   │   └── auth service/
│   │       ├── auth_checker.dart       # Stream-based auth gate widget
│   │       └── auth_service.dart       # Firebase Auth + Google Sign-In wrapper
│   ├── theme/
│   │   └── app colors/
│   │       └── app_colors.dart         # App-wide color palette
│   └── widgets/
│       ├── bottomNavBar/
│       │   └── bottom_nav_bar.dart     # Floating rounded bottom nav bar
│       ├── custom_button/
│       │   └── custom_button.dart      # Reusable full-width button
│       └── movie/
│           └── movie_widget.dart       # Movie card with cover image & rating badge
│
├── modules/
│   ├── auth/
│   │   └── pages/
│   │       ├── login_screen.dart       # Login form + Google Sign-In
│   │       ├── register_screen.dart    # Registration with avatar picker
│   │       └── forgot_pass_screen.dart # Password reset via email
│   ├── layout/
│   │   └── pages/
│   │       ├── layout_screen.dart      # Root scaffold with bottom nav
│   │       ├── home/
│   │       │   └── home_screen.dart    # PageView carousel of movies
│   │       ├── movie details/
│   │       │   └── movie_details_screen.dart  # Full detail + cast + suggestions
│   │       ├── search/
│   │       │   └── search_screan.dart  # (Placeholder)
│   │       ├── browse/
│   │       │   └── browse_screen.dart  # (Placeholder)
│   │       └── profile/
│   │           ├── profile_screen.dart # User profile + sign out
│   │           └── edit_screen.dart    # Edit display name & phone
│   ├── onboarding/
│   │   └── pages/
│   │       ├── onboarding_screen.dart  # Landing / "Explore Now" screen
│   │       ├── intro_screen.dart       # Paged intro carousel
│   │       └── pages_widget/
│   │           ├── pages.dart          # Onboarding page data model
│   │           └── Pages_widget.dart   # Individual onboarding page UI
│   └── splash/
│       └── splash_screen.dart          # Animated logo splash
│
├── main.dart                           # App entry point + Firebase init
├── main_wrapper.dart                   # SharedPreferences initial route helper
└── firebase_options.dart               # FlutterFire generated config
```

---

## 🔌 API

All network calls go through `ApiManager` using [Dio](https://pub.dev/packages/dio):

| Method | Endpoint | Description |
|---|---|---|
| `getMovieList()` | `list_movies.json` | Fetch paginated movie list |
| `getMovieDetails(id)` | `movie_details.json` | Full details, cast, screenshots |
| `getMovieSuggestions(id)` | `movie_suggestions.json` | Similar movies |

**Base URL:** `https://yts.lt/api/v2/`

---

## 🎨 Theme

| Token | Value | Usage |
|---|---|---|
| `black` | `#121312` | Backgrounds |
| `grey` | `#282A28` | Cards, nav bar, input fills |
| `yellow` | `#F6BD00` | Primary actions, icons, accents |
| `white` | `#FFFFFF` | Body text |
| `red` | `#E82626` | Watch button, destructive actions |

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `dio` | HTTP client for API calls |
| `firebase_core` | Firebase initialization |
| `firebase_auth` | Email/password + Google auth |
| `google_sign_in` | Google OAuth flow |
| `shared_preferences` | Persist onboarding state |
| `animate_do` | Splash screen animation |
| `animated_toggle_switch` | Toggle UI component |
| `cupertino_icons` | iOS-style icons |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.8.1`
- A Firebase project with **Authentication** enabled (Email/Password + Google)
- Android: `google-services.json` in `android/app/`
- iOS: `GoogleService-Info.plist` in `ios/Runner/`

### Setup

```bash
# Clone the repo
git clone <repo-url>
cd movies

# Install dependencies
flutter pub get

# Run the app
flutter run
```

> Firebase is already configured via `firebase_options.dart`. If you're connecting your own Firebase project, re-run `flutterfire configure` to regenerate this file.

---

## 🧭 Navigation Flow

```
AuthChecker (stream)
├── User logged in  → LayoutScreen (Home, Search, Browse, Profile)
│                        └── MovieWidget (tap) → MovieDetailsScreen
└── User logged out
    ├── First launch → OnboardingScreen → IntroScreen → LoginScreen
    └── Returning    → LoginScreen
                          ├── ForgotPassScreen
                          └── RegisterScreen
```

---

## 🔮 Roadmap

- [ ] Search screen implementation
- [ ] Browse / genre filter screen
- [ ] Watchlist with local persistence
- [ ] Watch history tracking
- [ ] BLoC state management migration
- [ ] Trailer playback via YouTube

---

## 📄 License

This project is for portfolio and educational purposes.
