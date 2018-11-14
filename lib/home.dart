import 'package:bitbuddy/utils/MyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:bitbuddy/view/currency_list_view.dart';
import 'package:bitbuddy/view/news_list_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _children = [NewsListView(), CurrencyListView(), null];
  int _currentIndex = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: buildAppBar(context, _currentIndex),
      body: _children[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      fixedColor: Color.fromRGBO(115, 222, 255, 1.0),
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.insert_drive_file),
          title: new Text('News'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.timeline),
          title: new Text('Tickers'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.timelapse), title: Text('Portfolio'))
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              MyNavigator.goToSettings(context);
            })
      ],
    ));
  }

  AppBar buildAppBar(BuildContext context, int index) {
    String titleText = "Bit Buddy";

  if(index == 0)
    {
      titleText = "News";
    } else if (index == 1)
      {
        titleText = "Tickers";
      } else {
    titleText = "Portfolio";
  }

  return AppBar(
      leading: new IconButton(
          icon: new Icon(Icons.menu, color:  Colors.white,),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          }),
      backgroundColor: Color.fromRGBO(115, 222, 255, 1.0),
      title: new Text(titleText,style: new TextStyle(color: Colors.white, fontSize: 28.0))
    );

  }
}
