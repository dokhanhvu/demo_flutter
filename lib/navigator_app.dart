import 'package:flutter/material.dart';

class navi extends StatefulWidget {
  @override
  _naviState createState() => new _naviState();
}

class _naviState extends State<navi> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(title: new Text('DemoNavi')),
            body: new Home()
        )
    );
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      body: new Column(
//        children: <Widget>[
//          new Expanded(
//            child: _getNavigator(context),
//          ),
//          new Expanded(
//            child: _getNavigator(context),
//          ),
//        ],
//      ),
      body: new MyTile()
    );
  }
}

class MyTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      onPressed: () =>
          Navigator.push(context, new MaterialPageRoute(builder: (cont){
            return new Scaffold(
              appBar: new AppBar(
                title: Text("New Page"),
              ),
              body: new Text("New Page"),
            );
          }
          )),
      child: new Text('Next'),
    );
  }
}


