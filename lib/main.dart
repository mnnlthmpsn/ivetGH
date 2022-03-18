import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/screens/categories.dart';
import 'package:vetgh/screens/home.dart';
import 'package:vetgh/screens/nominees.dart';
import 'package:vetgh/screens/splashScreen.dart';
import 'dart:developer' as developer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    hasNetwork();
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      setState(() {
        hasInternet = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      });
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      setState(() => hasInternet = false);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'VetGH',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(KTextTheme.textTheme),
        inputDecorationTheme: TextFieldTheme.textFieldTheme,
        primaryColor: KColors.kPrimaryColor,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: KColors.kLightColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'home': (context) => hasInternet ? const Home() : Text('No Internet'),
      },
    );
  }
}
