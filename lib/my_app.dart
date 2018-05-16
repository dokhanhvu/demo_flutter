import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/widget/home.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app/ui/widget/login.dart';
import 'package:flutter_app/ui/widget/splash_screen.dart';

class MyApp extends StatelessWidget {

  final AuthManager _authManager = new AuthManager();
  final Router router = new Router();

  MyApp(){
    //configureRouter(router, _authManager);
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

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != LoginScreen.routeName) {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginScreen(),
      fullscreenDialog: true,
    );
  }
}

final ThemeData _appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Color(0xFF00000),
    primaryColor: Color(0xFFffffff),
    buttonColor: Color(0xFF32CD32),
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

//typedef Widget HandlerFunc(BuildContext context, Map<String, dynamic> params);
//
//HandlerFunc buildLoginHandler(AuthManager authManager){
//      (BuildContext context, Map<String, dynamic> params) => new LoginScreen();
//}
//
//HandlerFunc buildHomeHandler(AuthManager authManager){
//      (BuildContext context, Map<String, dynamic> params) => new HomeScreen(params['username']);
//}
//
//void configureRouter(Router router, AuthManager authManager) {
//  router.define(
//      '/login',
//      handler: new Handler(handlerFunc: buildLoginHandler(authManager))
//  );
//
//  router.define(
//      '/home/:username',
//      handler: new Handler(handlerFunc: buildHomeHandler(authManager))
//  );
//}
