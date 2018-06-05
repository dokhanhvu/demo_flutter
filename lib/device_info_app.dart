import 'package:flutter/material.dart';

class DeviceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MediaQueryData queryData;



  @override
  Widget build(BuildContext context) {

    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Device Info"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'size (pixels): w=${queryData.size.width * devicePixelRatio}, h=${queryData.size.height * devicePixelRatio}',
          ),
          new Text(
            'devicePixelRatio: $devicePixelRatio',
          ),
          new Text(
            'size: w=${queryData.size.width}, h=${queryData.size.height}',
          ),
          new Text(
            'textScaleFactor: w=${queryData.textScaleFactor}',
          ),
        ],
      ),
    );
  }
}