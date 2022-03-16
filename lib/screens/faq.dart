import 'package:flutter/material.dart';
import 'package:vetgh/components/webViewBuilder.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: WebViewBuilder(url: 'https://www.vetgh.com/#/faq')
    );
  }
}
