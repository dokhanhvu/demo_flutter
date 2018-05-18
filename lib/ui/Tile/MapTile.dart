import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MapTile extends StatelessWidget{
  //final Map map;
  final Map map;

  //UserItem(this.map);
  MapTile(this.map);

  @override
  Widget build(BuildContext context) {
    User user = User.fromMap(map);

    return new Column(
      children: <Widget>[
        ListTile(
          leading: new CircleAvatar(
            backgroundImage: new NetworkImage(user.avatar),
            backgroundColor: Colors.grey,
          ),
          title: new Text(user.username),
        ),
        new Divider()
      ],
    );

  }
}
