import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/LocalDB.dart';
import 'package:bitbuddy/utils/MyNavigator.dart';
import 'package:bitbuddy/utils/IntroStrings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitbuddy/widgets/IntroCard.dart';

class IntroCardView extends StatefulWidget {
  IntroCardView({this.onIntroOver});

  final VoidCallback onIntroOver;

  @override
  State<StatefulWidget> createState() => IntroCardViewState();
}

class IntroCardViewState extends State<IntroCardView> {
  final PageController _pageController = new PageController();
  int _current = 0;
  int _total = 3;
  bool _last = false;

  void onPageChange(int page) {
    setState(() {
      _current = page;
      if (_current == _total) {
        _last = true;
        _setViewed();
      } else {
        _last = false;
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
        color: Colors.lightBlueAccent,
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
          child: Text(_current == 0 ? "" : IntroStrings.skip,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          onPressed: () => _current == 0
              ? null
              : _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut)),
      FlatButton(
        child: Text(_last ? IntroStrings.last : IntroStrings.next,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        onPressed: () => _last
            ? widget.onIntroOver()
            : _pageController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn),
      ),
    ];
  }

  PageView buildPageView() {
    return PageView(
      children: <Widget>[
        IntroCard(
            title: IntroStrings.titleCard1,
            body: IntroStrings.bodyCard1,
            icon: Icons.accessibility_new),
        IntroCard(
            title: IntroStrings.titleCard2,
            body: IntroStrings.bodyCard2,
            icon: Icons.trending_up),
        IntroCard(
            title: IntroStrings.titleCard3,
            body: IntroStrings.bodyCard3,
            icon: Icons.playlist_add_check),
        IntroCard(
            title: IntroStrings.titleCard4,
            body: IntroStrings.bodyCard4,
            icon: Icons.perm_device_information)
      ],
      controller: _pageController,
      onPageChanged: onPageChange,
    );
  }
}
