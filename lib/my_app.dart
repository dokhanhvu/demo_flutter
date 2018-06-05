import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/misc/routes.dart';
import 'package:flutter_app/ui/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  final AuthManager _authManager = new AuthManager();
  final Router router = new Router();

  MyApp() {
    configureRouter(router, _authManager);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: new SplashScreen(_authManager),
      onGenerateRoute: router.generator,
      theme: _appTheme,

    );
  }

}

final ThemeData _appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  var paint = new Paint();
  return base.copyWith(
    //accentColor: Color(0xFF00000),
    accentColor: Colors.lightBlueAccent,
    //primaryColor: Color(0xFFffffff),
    primaryColor: Colors.blue,
    buttonColor: Color(0xFF32CD32),
//    splashColor: Colors.lightGreenAccent,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textSelectionColor: Color(0xFFFEDBD0),
    errorColor: Color(0xFFC5032B),
    //TODO: Add the text themes (103)
    //TODO: Add the icon themes (103)
    //TODO: Decorate the inputs (103)
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
