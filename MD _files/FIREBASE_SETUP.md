# Firebase Setup (Flutter + Django + ML)

Use this when you are ready to connect real Firebase services.

## 1. Create Firebase project
1. Go to Firebase Console.
2. Create a new project named `stock_simulator`.

## 2. Add apps
### Android
1. Add Android app with package name from `android/app/build.gradle`.
2. Download `google-services.json`.
3. Place it in `Flutter/android/app/`.

### Web (optional for Chrome)
1. Add Web app.
2. Copy the Firebase config object for later.

## 3. Enable Auth
1. Enable Phone Auth.
2. Enable Email/Password (optional).

## 4. Firestore
1. Create Firestore database (test mode first).
2. Add collections:
   - users
   - watchlist
   - portfolio
   - transactions
   - alerts

## 5. Cloud Messaging (optional)
1. Enable Firebase Messaging.
2. Add FCM keys (later if you need push).

## 6. Flutter config
1. Run: `flutter pub get`
2. In `main.dart`, initialize Firebase only after config files exist.

## 7. Django stays
Keep Django for:
- market APIs
- trading simulation
- ML predictions

---

When you are ready, tell me and I will:
1. Add `google-services.json` wiring
2. Add `firebase_options.dart`
3. Initialize Firebase in `main.dart`
4. Create Firestore repositories for user data
