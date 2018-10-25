import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/MyNavigator.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.onSplashOver});
  @override
  final VoidCallback onSplashOver;
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 5000));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceIn);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    Timer(Duration(milliseconds: 5000), () => openNextPage());
  }

  openNextPage() {
    widget.onSplashOver();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(115, 222, 255, 1.0)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image(
                            image: new AssetImage("images/bitbuddylogo.jpg"),
                            height: _iconAnimation.value * 300,
                            width: _iconAnimation.value * 300,
                          )
                        ]),
                  )),
            ],
          )
        ]));
  }
}