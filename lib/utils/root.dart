import 'package:flutter/material.dart';
import 'package:bitbuddy/splash_screen.dart';
import 'package:bitbuddy/home.dart';

class Root extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _RootState();
}

enum RootStatus { splash, home }

class _RootState extends State<Root> {
  RootStatus _rootStatus = RootStatus.splash;
  RootStatus _afterSplash = RootStatus.home;
  RootStatus _afterIntro = RootStatus.home;

  void _afterSplashState(){
    setState(() {
      _rootStatus = _afterSplash;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_rootStatus) {
      case RootStatus.home:
        return new Home();
      case RootStatus.splash:
        return new SplashScreen(onSplashOver: _afterSplashState);
    }
  }
}
