import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roommates/LoginAndSignup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MaterialApp app = MaterialApp(
    title: 'roomates',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.secularOneTextTheme(),
    ),
    home: LoginAndSignup(),
    debugShowCheckedModeBanner: false,
  );
  runApp(MyApp(app));
}

class MyApp extends StatelessWidget {
  MaterialApp app;
  MyApp(this.app);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return app;
  }
}