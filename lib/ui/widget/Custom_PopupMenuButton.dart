import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/misc/function.dart';

class CustomPopupMenuButton extends StatelessWidget {

  final AuthManager _authManager;
  final BuildContext context;


  CustomPopupMenuButton(this._authManager, this.context);

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<OverflowItem>(
        onSelected: _getOverFlow(context),
        itemBuilder: (BuildContext context) {
          return [
            new PopupMenuItem<OverflowItem>(
                value: OverflowItem.LogOut, child: new Text('Log out'))
          ];
        });
  }

  void _overflow(OverflowItem selected) {
    switch (selected) {
      case OverflowItem.Settings:
        break;
      case OverflowItem.LogOut:
        _authManager.logout()
            .then((_) => Navigator.of(context, rootNavigator: true).pushReplacementNamed('/login'));
        break;
    }
  }

  GetOverflow _getOverFlow(BuildContext context) {
    return _overflow;
  }
}
