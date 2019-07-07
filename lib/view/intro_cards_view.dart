import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/LocalDB.dart';
import 'package:bitbuddy/utils/MyNavigator.dart';
import 'package:bitbuddy/utils/IntroStrings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroCard extends StatefulWidget {
  IntroCard({this.onIntroOver});

  final VoidCallback onIntroOver;

  @override
  State<StatefulWidget> createState() => IntroCardState();
}

class IntroCardState extends State<IntroCard> {
  final PageController _pageController = new PageController();
  int _current = 0;
  int _total = 3;
  bool _last;

  void onPageChange(int page) {
    setState(() {
      _current = page;
      if (_current == _total) {
        _last = true;
        _setViewed();
        widget.onIntroOver();
      }
    });
  }

  _setViewed() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(LocalDB.isIntro, true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 3,
              child: buildPageView(),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: children(context),
                ))
          ],
        ));
  }

  List<Widget> children(BuildContext context) {
    return <Widget>[
      FlatButton(
        child: Text(_last ? "" : IntroStrings.skip,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        onPressed: () => _last ? null : MyNavigator.goToHome(context),
      ),
      FlatButton(
        child: Text(_last ? IntroStrings.last : IntroStrings.next,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        onPressed: () => _last
            ? MyNavigator.goToHome(context)
            : _pageController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn),
      ),
    ];
  }

  PageView buildPageView() {
    return PageView(
      children: <Widget>[],
    );
  }
}
