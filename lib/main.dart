import 'package:eco_guardian_roverbin_app/pages/auth_screen.dart';
import 'package:eco_guardian_roverbin_app/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SMART GARBAGE DUMP',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: AuthScreen(),
      );
  }
}

