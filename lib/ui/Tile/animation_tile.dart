import 'package:flutter/material.dart';
import 'package:flutter_app/misc/function.dart';
import 'package:flutter_app/model/user.dart';

class AnimationTile<T> extends StatefulWidget {
  //final Map map;
  final T data;

  final WidgetAdapter<T> tileAdapter;

  final int duration;

  final bool isFadeIn;

  AnimationTile(this.data, this.tileAdapter, {this.duration: 300, this.isFadeIn: false});

  @override
  createState() => new _AnimationTileState<T>();
}

class _AnimationTileState<T> extends State<AnimationTile<T>>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  //NetworkImage image;

  Tween<double> _opacityTween;
  Tween<double> _sizeTween;

  _AnimationTileState();

  @override
  void initState() {
    super.initState();
    //image = NetworkImage(_user.avatar, scale: 6.0);
    _opacityTween = new Tween<double>(begin: widget.isFadeIn? 0.1 : 1.0, end: 1.0);
    _sizeTween = new Tween<double>(begin: 0.0, end: 20.0);

    controller = new AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    //animation = new Tween(begin: 0.0, end: 20.0).animate(controller);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Opacity(opacity: _opacityTween.evaluate(animation),
        child: new Container(
          margin: new EdgeInsets.only(left: 20.0 - _sizeTween.evaluate(animation)),
          child: widget.tileAdapter(widget.data)
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}