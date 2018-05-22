import 'package:flutter/material.dart';
import 'package:flutter_app/misc/function.dart';

class SignButton extends StatefulWidget {
  final HandleSubmit onPressed;
  final BuildContext context;

  SignButton({this.onPressed, this.context});

  @override
  _SignButtonState createState() => new _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  String _title;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _title = "SIGN IN";
  }

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      child: Text(_title),
      onPressed: onSubmit,
      splashColor: Colors.lightGreenAccent,
      color: isLoading ?   Theme.of(context).buttonColor.withOpacity(0.8) : Theme.of(context).buttonColor,
      elevation: 8.0,
    );
  }

  void onSubmit() {
    setState(() {
      _title = "SINGING IN ...";
      isLoading = true;
    });

    widget.onPressed().then((success) {
      //_title = "SIGN IN";
      if (success) {
        Navigator.pushReplacementNamed(widget.context, '/home');
      } else {
        //_title = "SIGN IN";
      }
    }).whenComplete(() {
      setState(() {
        _title = "SIGN IN";
        isLoading = false;
      });
    });
  }
}
