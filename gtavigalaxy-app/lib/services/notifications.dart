/// Push notifications via Firebase Cloud Messaging.
///
/// Firebase is not integrated yet: there is no Firebase project and no
/// `google-services.json`, and the native Firebase SDKs are not bundled
/// (they crashed the app at startup without a config). This is a no-op
/// placeholder so the app runs cleanly. Wire up FCM when ready.
class NotificationService {
  static bool available = false;

  static Future<void> init() async {
    available = false;
  }
}
