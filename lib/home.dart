import 'package:flutter/material.dart';
import 'package:bitbuddy/view/currency_list_view.dart';
import 'package:bitbuddy/view/news_list_view.dart';
import 'package:share/share.dart';
import 'package:launch_review/launch_review.dart';
import 'package:bitbuddy/utils/auth.dart';

class Home extends StatefulWidget {
  Home({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _children = [NewsListView(), CurrencyListView(), null];
  int _currentIndex = 1;
  String _email = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getEmailFromAuth().then((val) => setState(() {
      _email = val;
      print("here" + _email);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: buildAppBar(context, _currentIndex),
      body: _children[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar,
    );
  }

  BottomNavigationBar get buildBottomNavigationBar {
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

  Future<String> getEmailFromAuth() async {
    return await widget.auth.currentEmail();
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
                      backgroundColor: Colors.lightBlueAccent,
                      child: Image.asset("images/useraccountexample.jpg")),
                  accountName: new Text('Jack Hosking'),
                  accountEmail: new Text(_email),
                  otherAccountsPictures: <Widget>[
                    FlatButton(
                        child: new Icon(
                          Icons.share,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () {
                          Share.share(
                              'Come try Bit Buddy, a simple cryptocurreny portfolio app.');
                        }),
                    FlatButton(
                        child: new Icon(
                          Icons.rate_review,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () {
                          LaunchReview.launch(
                              androidAppId: 'com.skuu.bitbuddy');
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
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Sign Out'),
                          onTap: () {
                            widget.auth.signOut();
                            widget.onSignedOut();
                            Navigator.pop(context);
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
