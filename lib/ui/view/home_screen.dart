import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/view/followers.dart';
import 'package:flutter_app/ui/view/following.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';
import 'package:flutter_app/ui/view/randomwords.dart';
import 'package:flutter_app/ui/widget/Custom_PopupMenuButton.dart';

class HomeScreen extends StatelessWidget {

  final AuthManager _authManager;

  HomeScreen(this._authManager);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Demo_Flutter"),
            actions: [
              new CustomPopupMenuButton(_authManager, context)
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




