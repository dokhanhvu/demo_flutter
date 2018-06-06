import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/view/followers.dart';
import 'package:flutter_app/ui/view/following.dart';
import 'package:flutter_app/ui/view/home_screen.dart';
import 'package:flutter_app/ui/view/login_screen.dart';
import 'package:flutter_app/ui/view/main_screen.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';

typedef Widget HandlerFunc(BuildContext context, Map<String, dynamic> params);

HandlerFunc buildLoginHandler(AuthManager authManager) {
  return (BuildContext context, Map<String, dynamic> params) => new LoginScreen(authManager);
}

HandlerFunc buildHomeHandler(AuthManager authManager) {
  return (BuildContext context, Map<String, dynamic> params) =>
  new HomeScreen(authManager);
}

HandlerFunc buildMainHandler(authManager) {
  return (BuildContext context, Map<String, dynamic> params) =>
  new MainScreen(authManager);
}

HandlerFunc buildFollowersHandler(authManager) {
  return (BuildContext context, Map<String, dynamic> params) =>
  new Followers(params['username'].join(), authManager);
}

HandlerFunc buildFollowingHandler(authManager) {
  return (BuildContext context, Map<String, dynamic> params) =>
  new Following(params['username'].join(), authManager);
}

HandlerFunc buildProfileHandler(authManager) {
  return (BuildContext context, Map<String, dynamic> params) =>
  new ProfileOverview(params['id'].join(), authManager);
}

void configureRouter(Router router, AuthManager authManager) {
  router.define('/login',
      handler: new Handler(handlerFunc: buildLoginHandler(authManager)));

  router.define('/home',
      handler: new Handler(handlerFunc: buildHomeHandler(authManager)));

  router.define(
      '/users/:username/followers',
      handler: new Handler(handlerFunc: buildFollowersHandler(authManager))
  );

  router.define(
      '/users/:username/following',
      handler: new Handler(handlerFunc: buildFollowingHandler(authManager))
  );

  router.define(
      '/users/:id/profileoverview',
      handler: new Handler(handlerFunc: buildProfileHandler(authManager))
  );
}