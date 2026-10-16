# GTAVI Galaxy — Android App

Flutter app for [gtavigalaxy.com](https://www.gtavigalaxy.com). Android-first;
the same codebase builds iOS later (`flutter build ipa`).

## Features (v1)
- **News** — latest articles from the WordPress REST API, pull-to-refresh,
  infinite scroll
- **Countdown** — live GTA VI launch countdown (19 Nov 2026)
- **Search** — full-text search across all articles
- **Article reader** — hero image, formatted body, share, open-in-browser
- **Push notifications** — wired via Firebase Cloud Messaging, topic
  `breaking-news` (needs activation, see below)
- Dark Vice-City-style theme, launcher icon from the site logo

## Quick start (cloud build — recommended)
1. Create a free GitHub account and a new repository.
2. Upload this whole `app/` folder to the repo (or push with git).
3. Open the **Actions** tab → the *Build Android APK* workflow runs
   automatically (or press **Run workflow**).
4. When it finishes (~10 min), download **gtavigalaxy-apk** from the
   workflow's Artifacts section.
5. On an Android phone: open the downloaded APK → allow *Install unknown
   apps* once → install → open **GTAVI Galaxy**.

## Local build
Requires Flutter 3.38+ and the Android SDK:
```sh
flutter pub get
dart run flutter_launcher_icons
flutter build apk --debug        # test build
flutter build appbundle          # Play Store upload
```

## Activating push notifications
1. Create a free Firebase project at <https://console.firebase.google.com>.
2. Add an Android app with package name `com.gtavigalaxy.app`.
3. Download `google-services.json` into `android/app/`.
4. In `android/settings.gradle.kts` add the Google Services plugin, and apply
   it in `android/app/build.gradle.kts` (standard Firebase setup).
5. Send breaking-news pushes to the `breaking-news` topic from the Firebase
   console. Until this is done the app works fully — push is simply inactive.

## Play Store release checklist
- [ ] Release (signed) build: `flutter build appbundle`
- [ ] Play Console developer account ($25 one-time)
- [ ] Store listing: description, screenshots, feature graphic, privacy policy URL
- [ ] Content rating questionnaire, target audience, news-app declarations
- [ ] AdMob account for in-app ads (AdSense does not work inside apps)

## Project layout
```
lib/
  main.dart                 app entry, theme, bottom navigation
  models/post.dart          WordPress post model
  services/api.dart         wp-json client (posts, search)
  services/notifications.dart  FCM setup (safe no-op without config)
  screens/home_screen.dart  news feed
  screens/article_screen.dart  article reader
  screens/countdown_screen.dart  GTA VI countdown
  screens/search_screen.dart  search
  widgets/post_card.dart    article card
assets/icon/icon.png        launcher icon source
```
