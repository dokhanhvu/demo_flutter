import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/view/followers.dart';
import 'package:flutter_app/ui/view/following.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';
import 'package:flutter_app/ui/view/randomwords.dart';

class HomeScreen extends StatelessWidget {

  final AuthManager _authManager;

  HomeScreen(this._authManager);

//  void _overflow(OverflowItem selected) {
//    switch (selected) {
//      case OverflowItem.Settings:
//        break;
//      case OverflowItem.LogOut:
//        _authManager.logout()
//            .then((_) => Navigator.pushReplacementNamed(context, '/login'));
//        break;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Demo_Flutter"),
            actions: [
              new PopupMenuButton<OverflowItem>(
                  onSelected: (OverflowItem selected) {
                    switch (selected) {
                      case OverflowItem.Settings:
                        break;
                      case OverflowItem.LogOut:
                        _authManager.logout()
                            .then((_) => Navigator.pushReplacementNamed(context, '/login'));
                        break;
                    }
                  },
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
              new Tab(text: "Profile",),
              new Tab(text: "Following"),
              new Tab(text: "Follower"),
            ]),
          ),
          body: new TabBarView(children: [
            new ProfileOverview(_authManager.ownerName, _authManager),
            new Following(_authManager.ownerName, _authManager),
            new Followers(_authManager.ownerName, _authManager,),
          ]),
        ));
  }
}

enum OverflowItem {
  Settings,
  LogOut
}




