import 'package:chalet_sharks/firebase_options.dart';
import 'package:chalet_sharks/screens/Categories_screen.dart';
import 'package:chalet_sharks/screens/booking_screen.dart';
import 'package:chalet_sharks/screens/history_screen.dart';
import 'package:chalet_sharks/screens/login.dart';
import 'package:chalet_sharks/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/Chalet_screen_details.dart';
import 'screens/Chalets_screen.dart';
import 'screens/first.dart';
import 'screens/payment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 23, 132, 221)),
        ),
        home:First(),
        routes: {
          '/ first one': (context) => const ChaletScreen(),
          '/data': (context) => const ChaletDetails(),
          '/First': (context) => const First(),
          '/LoginScreen': (context) => LoginScreen(),
          '/SignupScreen': (context) => SignupScreen(),
          '/CategroyScreen': (context) => const CategroyScreen(),
          '/history': (context) => const HistoryScreen(),
          '/booking': (context) => const BookingScreen(),
          '/open': (context) => const Payment(),
        });
  }
}
