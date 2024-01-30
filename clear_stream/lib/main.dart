import 'package:clear_stream/StartUp/Auth/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Map/map.dart';
import 'Utility/checkBoxModel.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC8DIjdyEn14mM2s_JIL9CUDHFCaFK6wK0',
          appId: '1:987596278870:android:2dc2be8e61fd4f1e207ff7',
          messagingSenderId: '987596278870',
          projectId: 'clear-stream-429bf'));

  final GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CheckBoxesModel(),
      child: MaterialApp(
        home: MainPage(
          myMapKey: myMapKey,
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<MyMapState> myMapKey; // Declare myMapKey here
  const MyApp({super.key, required this.myMapKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Specify the initial route
      initialRoute: '/Start',
      // Define the routes
      routes: {
        '/Start': (context) =>
            MainPage(myMapKey: myMapKey), // Provide myMapKey here
        // Add other routes for different parts of your app as needed
      },
    );
  }
}
