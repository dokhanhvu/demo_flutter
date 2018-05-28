import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/view/followers.dart';
import 'package:flutter_app/ui/view/following.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';

class MainScreen extends StatefulWidget {

  final AuthManager _authManager;

  MainScreen(this._authManager);

  @override
  _MainScreenState createState() => new _MainScreenState(_authManager);
}

class _MainScreenState extends State<MainScreen> {
  /// This controller can be used to programmatically
  /// set the current displayed page
  PageController _pageController;

  /// Indicating the current displayed page
  /// 0: trends
  /// 1: feed
  /// 2: community
  int _page = 0;

  final AuthManager _authManager;

  _MainScreenState(this._authManager);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Demo_Flutter"),
          actions: [
            new PopupMenuButton<OverflowItem>(
                onSelected: _overflow,
                itemBuilder: (BuildContext context) {
                  return [
//                  new PopupMenuItem(value: OverflowItem.Settings,
//                      child: new Text('Settings')),
                    new PopupMenuItem<OverflowItem>(
                        value: OverflowItem.LogOut, child: new Text('Log out'))
                  ];
                })
          ],
        ),
        body: new PageView(
            children: [
              new ProfileOverview(widget._authManager),
              new Following(_authManager.ownerName, _authManager),
              new Container()
            ],

            /// Specify the page controller
            controller: _pageController,
            onPageChanged: onPageChanged
        ),
        bottomNavigationBar: new BottomNavigationBar(
            items: [
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.account_circle),
                  title: new Text("profiles")
              ),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.rss_feed),
                  title: new Text("feed")
              ),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.people),
                  title: new Text("community")
              )
            ],

            /// Will be used to scroll to the next page
            /// using the _pageController
            onTap: navigationTapped,
            currentIndex: _page
        )
    );
  }

  /// Called when the user presses on of the
  /// [BottomNavigationBarItem] with corresponding
  /// page index
  void navigationTapped(int page){

    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }


  void onPageChanged(int page){
    setState((){
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

  void _overflow(OverflowItem selected) {
    switch (selected) {
      case OverflowItem.Settings:
        break;
      case OverflowItem.LogOut:
        _authManager.logout()
            .then((_) => Navigator.pushReplacementNamed(context, '/login'));
        break;
    }
  }
}

enum OverflowItem {
  Settings,
  LogOut
}