import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vetgh/config.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'About Us',
            style: TextStyle(fontSize: 14),
          ),
          backgroundColor: KColors.kPrimaryColor,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            const SizedBox(height: 30),
            Lottie.asset('assets/lottie/about.json'),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Who we are?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text(
                      'Voting & E-Ticketing GH(VET GH) is digital platform (comprising of shortcode, web app & mobile app) for online event ticket sales and voting for competitive events like pageants, awards, TV shows in Africa and some parts of the world.'),
                  SizedBox(height: 20),
                  Text('Address: #3-5 Boundary Road, Danso Plaza,East Legon, Accra.'),
                  Text('Phone Number: 020 039 4444 / 024 407 4442'),
                  Text('Email: vetgh1@gmail.com'),
                  SizedBox(height: 40,),
                  Center(child: Text('© Copyrights 2022 VETGH All rights reserved.', style: TextStyle(fontSize: 12)))
                ],
              ),
            )
          ],
        ));
  }
}
