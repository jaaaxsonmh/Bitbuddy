import 'package:flutter/material.dart';
import 'package:bitbuddy/HomeScreen/home.dart';
import 'package:bitbuddy/splash_screen.dart';
import 'package:bitbuddy/utils/routers.dart';


var routes = <String, WidgetBuilder>{
  Routers.home: (BuildContext context) => Home(),
};

void main() => runApp(new MaterialApp(
  theme: ThemeData(primaryColor:  Colors.white),
  title: 'Bitbuddy',
  home: new SplashScreen(),
  routes: routes
));
