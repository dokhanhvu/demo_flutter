import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserTile extends StatelessWidget {
  //final Map map;
  final User user;

  //UserItem(this.map);
  UserTile(this.user);

  @override
  Widget build(BuildContext context) {

      return new ListTile(
        leading: new CircleAvatar(
          backgroundImage: new CachedNetworkImageProvider(user.avatar),
          backgroundColor: Colors.grey,
        ),
        title: new Text(user.username),
      );
    //}
  }
}