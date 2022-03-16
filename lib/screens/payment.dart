import 'package:flutter/material.dart';
import 'package:vetgh/components/loader.dart';
import 'package:vetgh/components/webViewBuilder.dart';
import 'package:vetgh/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatefulWidget {

  final String url;

  const Payment({Key? key, required this.url}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: KColors.kPrimaryColor,
      foregroundColor: Colors.white,
      title: const Text(
        'Complete Payment',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _body() {
    return WebViewBuilder(url: widget.url);
  }
}
