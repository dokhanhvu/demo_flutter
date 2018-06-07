import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/api.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/ui/view/randomwords.dart';
import 'package:flutter_app/ui/widget/Custom_PopupMenuButton.dart';

class ProfileOverview extends StatefulWidget {
  final AuthManager _authManager;
  final String _userName;

  ProfileOverview(this._userName, this._authManager);

  @override
  _ProfileOverviewState createState() => new _ProfileOverviewState(this._authManager, this._userName);
}

class _ProfileOverviewState extends State<ProfileOverview> {
  final AuthManager _authManager;
  final String _userName;

  _ProfileOverviewState(this._authManager, this._userName);

  Api api;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api = new Api(_authManager);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Demo_Flutter"),
        actions: [
          new CustomPopupMenuButton(_authManager, context)
        ],
        ),
      body: new Column(
        children: <Widget>[_buildProfileView()],
      ),
    );
//    return new Column(
//      children: <Widget>[_buildProfileView()],
//    );
  }

  Widget _buildProfileView() {
    return new FutureBuilder<User>(
      future: api.loadUser(_userName),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          default:
            return _buildProfileHeader(snapshot.data);
        }
      },
    );
  }

  Widget _buildProfileHeader(User user) {
    user = user != null ? user : new User(-1, null, null, null, 0, 0, 0);

    return new Container(
      margin: new EdgeInsets.only(top: 16.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildUserIdentity(user),
          new Padding(
            child: _buildUserInfo(user),
            padding: new EdgeInsets.only(top: 24.0, bottom: 8.0),
          ),
//          new Divider()
        ],
      ),
    );
  }

  Widget _buildUserIdentity(User user) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Padding(
            child: new CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.white,
              backgroundImage: user.avatar != null ? new CachedNetworkImageProvider(
                  user.avatar) : null,
            ),
            padding: const EdgeInsets.only(right: 16.0),
          ),
          new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: new Text(
                    user.name != null ? user.name : '',
                    style: new TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
              new Text(user.login != null ? user.login : ''),
            ],
          )
        ]
    );
  }

  Widget _buildUserInfo(User user) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(
          onPressed: () {
            //Navigator.pushNamed(context, '/users/${user.login}/repos');
          },
          child: new Column(
            children: <Widget>[
              new Text(user.publicRepos.toString()),
              const Text('Repositories')
            ],
          ),
        ),
        new FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/users/${user.login}/followers');
//              Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
//                builder: (context) {
//                  return new RandomWords();
//                }
//              ));
            },
            child: new Column(
              children: <Widget>[
                new Text(user.followers.toString()),
                const Text('Followers')
              ],
            )),
        new FlatButton(
            onPressed: () {
              //Navigator.pushNamed(context, '/users/${user.login}/following');
            },
            child: new Column(
              children: <Widget>[
                new Text(user.following.toString()),
                const Text('Following')
              ],
            )),
      ],
    );
  }
}
