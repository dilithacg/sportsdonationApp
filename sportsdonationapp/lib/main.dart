import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportsdonationapp/src/features/screens/Home_Screen/Categories.dart';

//import 'package:introduction_screen/introduction_screen.dart';
import 'package:sportsdonationapp/src/features/screens/Login_Register/login_screen.dart';
import 'package:sportsdonationapp/src/features/screens/on_boarding/onboarding_screen.dart';
//import 'package:sportsdonationapp/src/features/screens/on_boarding/onboarding_screen.dart';

import 'package:sportsdonationapp/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}




