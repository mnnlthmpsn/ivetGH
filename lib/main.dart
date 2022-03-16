import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/screens/categories.dart';
import 'package:vetgh/screens/home.dart';
import 'package:vetgh/screens/nominees.dart';
import 'package:vetgh/screens/vote.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      routes: {
        '/': (context) => const Home(),
      },
    );
  }
}
