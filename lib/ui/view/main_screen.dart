import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/view/followers.dart';
import 'package:flutter_app/ui/view/following.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';
import 'package:flutter_app/ui/widget/Custom_PopupMenuButton.dart';

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

  List<Widget> list;

  PageView pageView = null;

  final AuthManager _authManager;

  _MainScreenState(this._authManager);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Demo_Flutter"),
//          actions: [
//            new CustomPopupMenuButton(_authManager, context)
//          ],
//        ),
        body: /*_getPageView()*/new PageView(

            children: [
              new ProfileOverview(_authManager.ownerName, _authManager),
              new Following(_authManager.ownerName, _authManager,  key: new ValueKey<String>('FollowingList'), ),
              new Followers(_authManager.ownerName, _authManager, key: new ValueKey<String>('FollowersList'), )
            ],

            /// Specify the page controller
            controller: _pageController,
            onPageChanged: onPageChanged
        ),
//        new PageView.builder(
//          itemCount: list.length,
//          itemBuilder: (BuildContext context, int index){
//            return list[index];
//          },
//          controller: _pageController,
//
//        ),
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

  Widget _getPageView() {
    if (pageView == null) {
      pageView = new PageView.builder(
        key: new PageStorageKey<PageView>(pageView),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
        controller: _pageController,

      );
    }
    return pageView;
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
    list = <Widget>[
      new ProfileOverview(_authManager.ownerName, _authManager),
      new Following(_authManager.ownerName, _authManager),
      new Followers(_authManager.ownerName, _authManager),
    ];
    _pageController = new PageController(
      keepPage: true,
      viewportFraction: 1.0
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}
