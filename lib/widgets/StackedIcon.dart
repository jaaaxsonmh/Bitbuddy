import 'package:flutter/material.dart';

class StackedIcon extends StatelessWidget {
  final double size = 60.0;

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Container(
            margin: new EdgeInsets.only(left: 0.0, top: 0.0),
            height: size,
            width: size,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(50.0),
                color: Colors.red),
            child: new Icon(
              Icons.playlist_add_check,
              color: Colors.white,
            )),
        new Container(
            margin: new EdgeInsets.only(left: 20.0, top: 80.0),
            height: size,
            width: size,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(50.0),
                color: Colors.amber),
            child: new Icon(
              Icons.trending_up,
              color: Colors.white,
            )),
        new Container(
            margin: new EdgeInsets.only(left: 90.0, top: 10.0),
            height: size,
            width: size,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(50.0),
                color: Colors.blue),
            child: new Icon(
              Icons.perm_device_information,
              color: Colors.white,
            )),
        new Container(
            margin: new EdgeInsets.only(right: 75.0, top: 45.0),
            height: size,
            width: size,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(50.0),
                color: Colors.green),
            child: new Icon(
              Icons.accessibility_new,
              color: Colors.white,
            )),
      ],
    );
  }
}
