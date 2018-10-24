import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/routers.dart';

class MyNavigator{
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, Routers.home);
  }
}