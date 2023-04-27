import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './Screens/Welcome/welcome_screen.dart';
import 'constants.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,builder:(context,snapshot){
      if (snapshot.hasError) {
      }
      if (snapshot.connectionState == ConnectionState. waiting)
      {
        return const Center (child: CircularProgressIndicator()); }
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Video Conference",
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const WelcomeScreen(),
      );
    });
  }
}

