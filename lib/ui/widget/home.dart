import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widget/Followers.dart';
import 'package:flutter_app/ui/widget/Following.dart';
import 'package:flutter_app/ui/widget/RandomWords.dart';

class HomeScreen extends StatefulWidget {

  final String _username;

  HomeScreen(this._username);

  @override
  createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 1,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Demo_Flutter"),
            bottom: new TabBar(tabs: [
              new Tab(text: "Follower"),
              new Tab(text: "Following"),
              new Tab(text: "NavigatorDemo",)
            ]),
          ),
          body: new TabBarView(children: [ new RandomWords()]),
        ));
  }
}

