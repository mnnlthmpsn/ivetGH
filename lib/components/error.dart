import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vetgh/config.dart';

class KError extends StatelessWidget {
  const KError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
        child: Column(
          children: [
            Lottie.asset('assets/lottie/error.json', height: 150),
            Text('An Unexpected error occured', style: TextStyle(fontWeight: FontWeight.bold, color: KColors.kDarkColor.withOpacity(.6)),)
          ],
        ),
      ),
    );
  }
}
