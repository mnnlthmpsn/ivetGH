import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/screens/about.dart';
import 'package:vetgh/screens/contact.dart';
import 'package:vetgh/screens/faq.dart';
import 'package:vetgh/screens/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeScreen = 0;

  final List<Map<String, dynamic>> _bottomMenu = [
    {'label': 'Home', 'icon': const Icon(Icons.home_rounded)},
    {'label': 'About', 'icon': const Icon(Icons.info_rounded)},
    {'label': 'Contact', 'icon': const Icon(Icons.phone_enabled_rounded)},
    {'label': 'FAQ', 'icon': const Icon(Icons.question_answer_rounded)},
  ];

  final List<Widget> pages = [
    Index(),
    About(),
    Contact(),
    FAQ()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: KColors.kPrimaryColor),
        toolbarHeight: 0,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: pages[activeScreen],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 6,
      showUnselectedLabels: true,
      unselectedFontSize: 10,
      selectedFontSize: 10,
      showSelectedLabels: true,
      selectedItemColor: KColors.kPrimaryColor,
      unselectedItemColor: KColors.kDarkColor.withOpacity(.8),
      backgroundColor: Colors.grey.shade200,
      onTap: (index) => setState(() => activeScreen = index),
      currentIndex: activeScreen,
      items: _bottomMenu
          .map((menu) =>
              BottomNavigationBarItem(label: menu['label'], icon: menu['icon']))
          .toList(),
    );
  }
}
