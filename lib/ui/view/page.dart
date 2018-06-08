import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/widget/Custom_PopupMenuButton.dart';

class Page extends StatelessWidget {

  final PageType pageType;
  final Widget child;
  final Text title;
  final AuthManager authManager;

  Page({this.pageType = PageType.Activity, @required this.child, this.title, this.authManager});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(context){
    switch(this.pageType){
      case PageType.Fragment:
        return this.child;
      case PageType.Activity:
      default:
        return new Scaffold(
          appBar: new AppBar(
            title: title,
            actions: [
              new CustomPopupMenuButton(this.authManager, context)
            ],
          ),
          body: this.child,
        );
    }
  }
}

enum PageType{
  Activity,
  Fragment
}
