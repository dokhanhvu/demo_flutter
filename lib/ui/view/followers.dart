import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/api.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/ui/Tile/user_tile.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';
import 'package:flutter_app/ui/widget/Custom_PopupMenuButton.dart';
import 'package:flutter_app/ui/widget/loadinglistview.dart';

class Followers extends StatefulWidget {
  final int pageSize;
  final int pageThreshold;
  final String _userName;
  final AuthManager _authManager;

  Followers(this._userName, this._authManager,
      {this.pageSize: 20, this.pageThreshold: 3,
        Key key, }) : super(key: key);

  @override
  createState() => new FollowersState();
}

class FollowersState extends State<Followers>{

  Widget w;
  final Router router = new Router();

  FollowersState(){

    var rootListHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) => w);
    var profileHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return new ProfileOverview(params['id'].join(), widget._authManager);
        });
    var subListHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return new Scaffold(
              appBar: new AppBar(
                actions: [
                  new CustomPopupMenuButton(widget._authManager, context)
                ],
              ),
              body: w);
        });

    router.define('/', handler: rootListHandler);
    router.define('/follower/:id', handler: profileHandler);
    router.define('/users/:id/followers', handler: subListHandler);
  }

  @override
  Widget build(BuildContext context) {

    if(w == null) {
      w = new LoadingListView<User>(
        request,
        widgetAdapter: adaptTile,
        pageSize: widget.pageSize,
        pageThreshold: widget.pageThreshold,
      );
    }

    return new Scaffold(
      //key: new PageStorageKey<FollowersState>(this),
      body: new Navigator(
        initialRoute: '/',
        onGenerateRoute: router.generator,
      ),
    );
    //return w;
  }

  Future<List<User>> request(int page, int pageSize) async {
    Api api = new Api(widget._authManager);
    return api.getFollowers(page, pageSize, widget._userName);
  }

  Widget adaptTile(User user) {
    return new UserTile(user, widget._authManager);
  }

//Widget adapt(User user){
//  return new AnimationTile(user, adaptTile);
//}

}

typedef Widget HandlerFunc(BuildContext context, Map<String, dynamic> params);