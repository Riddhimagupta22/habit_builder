import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habit_tracker/Comman/splash_screen.dart';
import 'package:habit_tracker/Controller/habit_controller.dart';
import 'package:habit_tracker/Services/notification_services.dart';

import 'Controller/analytics_controller.dart';
import 'Modules/Auth/signup_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  await GetStorage.init();
  Get.put(StreakController());
  Get.put(HabitController());
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(255, 92, 0, 1)),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
