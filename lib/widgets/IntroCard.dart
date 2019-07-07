import 'package:flutter/material.dart';

class IntroCard extends StatefulWidget {
  final icon, title, color, src, body;

  IntroCard(
      {this.title,
      this.body,
      this.icon,
      this.color = Colors.lightBlueAccent,
      this.src});

  @override
  State<StatefulWidget> createState() => IntroCardViewState();
}

class IntroCardViewState extends State<IntroCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation = Tween(begin: -225.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.elasticInOut));
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: Material(
        animationDuration: Duration(milliseconds: 700),
        elevation: 1.5,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Transform(transform: new Matrix4.translationValues(_animation.value, 0.0, 0.0),
            child: new Text(
              widget.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: widget.color),
              )
            ),
            new Transform(
              transform:
              new Matrix4.translationValues(_animation.value, 0.0, 0.0),
              child: new Text(
                widget.body,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: widget.color),
              ),
            ),
            new Icon(widget.icon, size: 80.0, color: widget.color),
            new Image.network(widget.src ?? "")
          ]
        )
      )
    );
  }
}
