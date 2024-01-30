import 'package:clear_stream/StartUp/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Map/map.dart';
import 'auth_page.dart';

class MainPage extends StatelessWidget {

  final GlobalKey<MyMapState> myMapKey;

  const MainPage({super.key, required this.myMapKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  HomePage(myMapKey: myMapKey,); // Assuming you have a UserMainPage widget
          } else {
            return  const AuthPage();
          }
        },
      ),
    );
  }
}

class UserMainPage extends StatelessWidget {
  const UserMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with your user MainPage UI
    return const Center(
      child: Text('User MainPage'),
    );
  }
}
