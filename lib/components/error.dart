import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vetgh/config.dart';

class KError extends StatefulWidget {
  final String? errorMsg;
  const KError({Key? key, this.errorMsg}) : super(key: key);

  @override
  State<KError> createState() => _KErrorState();
}

class _KErrorState extends State<KError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/error.json', height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.errorMsg!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: KColors.kDarkColor.withOpacity(.6)),
            ),
          ),
        ],
      ),
    );
  }
}
