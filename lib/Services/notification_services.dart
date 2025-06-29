import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _messaging = FirebaseMessaging.instance;

  Future initNotification() async {
    await _messaging.requestPermission();
    final token = await _messaging.getToken();
    print('FCM Token: $token');

  }
}
