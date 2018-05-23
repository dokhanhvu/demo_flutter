import 'package:flutter/material.dart';

class TabBarDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Demo_Flutter"),
            bottom: new TabBar(
                tabs: [
                  new Tab(text: "Follower"),
                  new Tab(text: "Following"),
                ]
            ),
          ),
          body: new TabBarView(
              children: [

              ]
          ),
        )
    );
  }
}