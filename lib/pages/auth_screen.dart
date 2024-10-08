import 'package:eco_guardian_roverbin_app/pages/ui_overview_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'log_or_reg_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return UIOverviewScreen();
            }
            else {
              return LoginOrRegisterScreen();
            }
          }
      ),
    );
  }
}

