import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/api.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/ui/Tile/UserTile.dart';
import 'package:flutter_app/ui/widget/LoadingListView.dart';

class Followers extends StatefulWidget{

  final int pageSize;
  final int pageThreshold;
  final String _userName;
  final AuthManager _authManager;

  Followers(this._userName, this._authManager, {this.pageSize: 20, this.pageThreshold: 3});

  @override
  createState() => new FollowersState();

}

class FollowersState extends State<Followers>{

  @override
  Widget build(BuildContext context) {
    Widget w;
    w = new LoadingListView<User>(
        request, widgetAdapter: adapt, pageSize: widget.pageSize, pageThreshold: widget.pageThreshold,);
    return w;
  }

  Future<List<User>> request(int page, int pageSize) async {
    Api api = new Api(widget._authManager);
    return api.getFollowers(page, pageSize, widget._userName);
  }

}

Widget adapt(User user, {Animation<double> animation}){
  return new UserTile(user);
}