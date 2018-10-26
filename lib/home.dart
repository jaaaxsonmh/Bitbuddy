import 'package:flutter/material.dart';
import 'package:bitbuddy/view/currency_list_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _children = [null, CurrencyListView(), null];
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: Image.asset("images/bitbuddylogo.jpg"),
        backgroundColor: Color.fromRGBO(115, 222, 255, 1.0),
        title: new Text("Bit Buddy",
            style: new TextStyle(color: Colors.white, fontSize: 28.0)),
        centerTitle: true,
      ),
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
}
