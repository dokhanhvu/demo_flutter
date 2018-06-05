import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/misc/routes.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';

//class UserTile extends StatelessWidget{
//  //final Map map;
//  final User _user;
//
//  //UserItem(this.map);
//  UserTile(this._user);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Column(
//      children: <Widget>[
//        ListTile(
//          leading: new CircleAvatar(
//            backgroundImage: CachedNetworkImageProvider(_user.avatar, scale: 6.0),
//            backgroundColor: Colors.grey,
//          ),
//          title: new Text(_user.username),
//
//        ),
//        new Divider()
//      ],
//    );
//
//  }
//}

class UserTile extends StatefulWidget {
  //final Map map;
  final User _user;
  final AuthManager _authManager;

  UserTile(this._user, this._authManager);

  @override
  createState() => new _UserTileState(_user, _authManager);
}

class _UserTileState extends State<UserTile>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CachedNetworkImageProvider image;
  final User _user;
  final AuthManager _authManager;

  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 20.0);

  _UserTileState(this._user, this._authManager);

  @override
  void initState() {
    super.initState();
    image = CachedNetworkImageProvider(_user.avatar, scale: 6.0);
    controller = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    //animation = new Tween(begin: 0.0, end: 20.0).animate(controller);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: new Container(
          margin:
              new EdgeInsets.only(left: 20.0 - _sizeTween.evaluate(animation)),
          child: new Column(
            children: <Widget>[
              ListTile(
                leading: new CircleAvatar(
                  backgroundImage: image,
                  backgroundColor: Colors.grey,
                ),
                title: new Text(_user.login),
//                onTap: () {
//                  Navigator.pushNamed(
//                      context, '/users/${_user.login}/profileoverview');
//                },
                trailing: FlatButton(
                  child: Text('Click'),
                  onPressed: () => Navigator.pushNamed(context, '/follower/${_user.login}'),
                ),
              ),
              new Divider()
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}
