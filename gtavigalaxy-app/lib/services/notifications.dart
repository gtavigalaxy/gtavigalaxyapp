import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Push notifications via Firebase Cloud Messaging.
///
/// ACTIVATION: drop your `google-services.json` from the Firebase console into
/// `android/app/` and apply the Google Services Gradle plugin (see README).
/// Until then, init() safely no-ops and the app works fully without push.
class NotificationService {
  static bool available = false;

  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      // Breaking GTA 6 news topic - send to this topic from Firebase console.
      await messaging.subscribeToTopic('breaking-news');
      available = true;
    } catch (_) {
      // No google-services.json yet: push disabled, everything else works.
      available = false;
    }
  }
}
