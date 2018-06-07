import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/api.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/Tile/map_tile.dart';
import 'package:flutter_app/ui/widget/Custom_PopupMenuButton.dart';
import 'package:flutter_app/ui/widget/loadinglistview.dart';

class Following extends StatefulWidget {
  final int pageSize;
  final int pageThreshold;
  final String _userName;
  final AuthManager _authManager;

  Following(this._userName, this._authManager,
      {this.pageSize: 20, this.pageThreshold: 3, Key key})
      : super(key: key);

  @override
  createState() => new FollowingState();
}

class FollowingState extends State<Following>{
  Widget w;

  @override
  Widget build(BuildContext context) {
    if (w == null) {
      w = new LoadingListView<Map>(
        request,
        widgetAdapter: adaptTile,
        pageSize: widget.pageSize,
        pageThreshold: widget.pageThreshold,
      );
    }
    return new Scaffold(
      key: new PageStorageKey<FollowingState>(this),
        appBar: new AppBar(
          actions: [
            new CustomPopupMenuButton(widget._authManager, context)
          ],
        ),
        body: w);
    return w;
  }

  Future<List<Map>> request(int page, int pageSize) async {
    Api api = new Api(widget._authManager);
    return api.getFollowing2(page, pageSize, widget._userName);
  }
}

//Widget adapt(Map map){
//  return new AnimationTile(map, adaptTile);
//}

Widget adaptTile(Map user) {
  return new MapTile(user);
}
