// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/misc/colors.dart';

class LoginScreen extends StatefulWidget {
  final AuthManager _authManager;
  static const routeName = '/login';

  LoginScreen(this._authManager);

  @override
  _LoginPageState createState() => _LoginPageState(_authManager);
}

class _LoginPageState extends State<LoginScreen> {
  final AuthManager _authManager;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  _LoginPageState(this._authManager);

  void _handleSubmit() {
    _authManager
        .login(_usernameController.text, _passwordController.text)
        .then((success) {
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // TODO show an error
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                new Image.asset(
                  'assets/ic_github_icon.png',
                  width: 100.0,
                  height: 100.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Sign in to Github',
                  style: new TextStyle(fontSize: 23.0),
                ),
              ],
            ),
            SizedBox(height: 12.0),
//            new Container(
//              child: new Form(
//                  child: new Column(
//                children: <Widget>[
//                  new TextFormField(
//                    key: new Key('username'),
//                    controller: _usernameController,
//                    decoration: new InputDecoration(
//                        hintText: "Username or email"),
//                    autofocus: true,
//                  ),
//                  SizedBox(height: 12.0),
//                  new TextFormField(
//                    controller: _passwordController,
//                    decoration:
//                        new InputDecoration(hintText: "Password"),
//                    obscureText: true,
//                  ),
//                  SizedBox(height: 12.0),
//                  new RaisedButton(
//                    shape: new RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
//                    ),
//                    child: Text('NEXT'),
//                    onPressed: _handleSubmit,
//                    splashColor: Colors.lightGreenAccent,
//                    elevation: 8.0,
//                  ),
//                ],
//              )),
//            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username or email',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 12.0),
            RaisedButton(
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              child: Text('NEXT'),
              onPressed: _handleSubmit,
              splashColor: Colors.lightGreenAccent,
              elevation: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
//
//class PrimaryColorOverride extends StatelessWidget {
//  const PrimaryColorOverride({Key key, this.color, this.child})
//      : super(key: key);
//
//  final Color color;
//  final Widget child;
//
//  @override
//  Widget build(BuildContext context) {
//    return Theme(
//      child: child,
//      data: Theme.of(context).copyWith(primaryColor: color),
//    );
//  }
//}
