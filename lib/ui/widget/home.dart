import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/widget/Followers.dart';
import 'package:flutter_app/ui/widget/Following.dart';
import 'package:flutter_app/ui/widget/RandomWords.dart';

class HomeScreen extends StatefulWidget {

  final AuthManager _authManager;

  HomeScreen(this._authManager);

  @override
  createState() => new HomeScreenState(_authManager);
}

class HomeScreenState extends State<HomeScreen> {

  final AuthManager _authManager;

  HomeScreenState(this._authManager);

  void _overflow(OverflowItem selected) {
    switch (selected) {
      case OverflowItem.Settings:
        break;
      case OverflowItem.LogOut:
        _authManager.logout()
            .then((_) => Navigator.pushReplacementNamed(context, '/login'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Demo_Flutter"),
            actions: [
              new PopupMenuButton<OverflowItem>(
                  onSelected: _overflow,
                  itemBuilder: (BuildContext context) {
                    return [
//                  new PopupMenuItem(value: OverflowItem.Settings,
//                      child: new Text('Settings')),
                      new PopupMenuItem<OverflowItem>(
                          value: OverflowItem.LogOut, child: new Text('Log out'))
                    ];
                  })
            ],
            bottom: new TabBar(tabs: [
              new Tab(text: "Follower"),
              new Tab(text: "Following"),
              new Tab(text: "NavigatorDemo",)
            ]),
          ),
          body: new TabBarView(children: [new Followers(widget._authManager.ownerName, widget._authManager), new Following(widget._authManager.ownerName, widget._authManager), new RandomWords()]),
        ));
  }
}

enum OverflowItem {
  Settings,
  LogOut
}




