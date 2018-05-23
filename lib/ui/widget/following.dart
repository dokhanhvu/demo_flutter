import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/api.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/ui/Tile/animation_tile.dart';
import 'package:flutter_app/ui/Tile/map_tile.dart';
import 'package:flutter_app/ui/Tile/user_tile.dart';
import 'package:flutter_app/ui/widget/loadinglistview.dart';

class Following extends StatefulWidget{

  final int pageSize;
  final int pageThreshold;
  final String _userName;
  final AuthManager _authManager;

  Following(this._userName, this._authManager, {this.pageSize: 20, this.pageThreshold: 3});

  @override
  createState() => new FollowersState();

}

class FollowersState extends State<Following>{

  @override
  Widget build(BuildContext context) {
    Widget w;
    w = new LoadingListView<Map>(
      request, widgetAdapter: adapt, pageSize: widget.pageSize, pageThreshold: widget.pageThreshold,);
    return w;
  }

  Future<List<Map>> request(int page, int pageSize) async {
    Api api = new Api(widget._authManager);
    return api.getFollowing2(page, pageSize, widget._userName);
  }

}

Widget adapt(Map map){
  return new AnimationTile(map, adaptTile);
}

Widget adaptTile(Map map){
  return new MapTile(map);
}