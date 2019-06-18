import 'package:bitbuddy/utils/MyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:bitbuddy/view/currency_list_view.dart';
import 'package:bitbuddy/view/news_list_view.dart';
import 'package:share/share.dart';

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
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                //TODO:: Update to user account, email, and picture based on firebase auth / email.
                new UserAccountsDrawerHeader(
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: new Icon(Icons.add_a_photo),
                  ),
                  accountName: new Text('Jack Hosking'),
                  accountEmail: new Text('me@jackhosking.co.nz'),
                  otherAccountsPictures: <Widget>[
                    FlatButton(
                        child: new Icon(
                          Icons.rate_review,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () {
                          Share.share(
                              'Come try Bit Buddy, a simple cryptocurreny portfolio.');
                        }),
                    FlatButton(
                        child: new Icon(
                          Icons.cake,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () {
                          showAboutDialog(
                            context: context,
                            applicationIcon: Image.asset(
                                "images/bitbuddylogo.jpg",
                                width: 50.0),
                            applicationVersion: 'version 0.3',
                          );
                        })
                  ],
                ),
              ],
            ),
          ),
          Container(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            MyNavigator.goToSettings(context);
                          }),
                    ],
                  ))))
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, int index) {
    String titleText = "Bit Buddy";

    if (index == 0) {
      titleText = "News";
    } else if (index == 1) {
      titleText = "Tickers";
    } else {
      titleText = "Portfolio";
    }

    return AppBar(
        leading: new IconButton(
            icon: new Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        title: new Text(titleText, style: new TextStyle(fontSize: 28.0)));
  }
}
