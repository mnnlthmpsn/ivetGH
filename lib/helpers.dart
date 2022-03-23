import 'package:flutter/material.dart';
import 'dart:io';

void newPage(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

void newPageDestroyPrevious(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}
