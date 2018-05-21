import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';

class UserTile extends StatelessWidget {
  //final Map map;
  final User user;

  //UserItem(this.map);
  UserTile(this.user);

  @override
  Widget build(BuildContext context) {

    return new Column(
      children: <Widget>[
    ListTile(
    leading: new CircleAvatar(
      backgroundImage: NetworkImage(user.avatar, scale: 6.0),
    backgroundColor: Colors.grey,
    ),
    title: new Text(user.username),

    ),
        new Divider()
      ],
    );

    //}
  }
}