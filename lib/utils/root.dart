import 'package:flutter/material.dart';
import 'package:bitbuddy/splash_screen.dart';
import 'package:bitbuddy/home.dart';
import 'package:bitbuddy/utils/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitbuddy/utils/database.dart';
import 'package:bitbuddy/view/login_page_view.dart';
import 'package:bitbuddy/view/intro_cards_view.dart';


class Root extends StatefulWidget {
  Root({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootState();
}

enum RootStatus { splash, home, intro, signedIn, notSignedIn }

class _RootState extends State<Root> {
  RootStatus _rootStatus = RootStatus.splash;
  RootStatus _afterSplash = RootStatus.intro;
  RootStatus _afterIntro = RootStatus.notSignedIn;

  void initState() {
    super.initState();
    _getCurrentState();
  }

  void _afterSplashState(){
    setState(() {
      _rootStatus = _afterSplash;
    });
  }

  void _afterIntroState() {
    setState(() {
      _rootStatus = _afterIntro;
    });
  }

  void _signedIn() {
    setState(() {
      _rootStatus = RootStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _rootStatus = RootStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_rootStatus) {
      case RootStatus.notSignedIn:
        return new LoginPageView(auth: widget.auth, onSignedIn: _signedIn);
      case RootStatus.signedIn:
        return new Home(auth: widget.auth, onSignedOut: _signedOut);
      case RootStatus.intro:
        return new IntroCardView(onIntroOver: _afterIntroState);
      case RootStatus.splash:
        return new SplashScreen(onSplashOver: _afterSplashState);
      case RootStatus.home:
        return new Home(auth: widget.auth, onSignedOut: _signedOut);
    }
  }

  _getCurrentState() async {
    var uid = await widget.auth.currentEmail();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var introCardsViewed = preferences.getBool(Database.isIntro) ?? false;

    if(uid == null) {
      _afterIntro = RootStatus.notSignedIn;
    } else {
      _afterIntro = RootStatus.home;
    }

    if(introCardsViewed) {
      _afterSplash = RootStatus.home;
    } else {
      _afterSplash = RootStatus.intro;
    }
  }
}
