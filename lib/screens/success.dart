import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vetgh/config.dart';
import 'package:vetgh/helpers.dart';

class SuccessPage extends StatelessWidget {
  final String message;

  const SuccessPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .15,
              ),
              Lottie.asset('assets/lottie/success.json'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(message),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 40),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .065,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: KColors.kDarkColor),
                  onPressed: () => newPageDestroyPrevious(context, 'home'),
                  label: Text('Go Home'),
                  icon: Icon(Icons.home_rounded),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
