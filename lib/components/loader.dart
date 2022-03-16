import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class KLoader extends StatelessWidget {
  const KLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Lottie.asset('assets/lottie/loading.json')),
    );
  }
}
