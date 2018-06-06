import 'package:flutter/material.dart';
import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/ui/view/followers.dart';
import 'package:flutter_app/ui/view/following.dart';
import 'package:flutter_app/ui/view/profile_overview.dart';

class ViewPager extends StatefulWidget {

  final AuthManager _authManager;

  ViewPager(this._authManager);

  @override
  _ViewPagerState createState() => _ViewPagerState(this._authManager);
}

class _ViewPagerState extends State<ViewPager> with AutomaticKeepAliveClientMixin<ViewPager>, SingleTickerProviderStateMixin<ViewPager>{

  final AuthManager _authManager;

  _ViewPagerState(this._authManager);

  TabController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: TabBarView(
            children: [
              ProfileOverview(_authManager.ownerName, _authManager),
              Following(_authManager.ownerName, _authManager, /*key: new ValueKey<String>('FollowingList'),*/),
              Followers(_authManager.ownerName, _authManager,/*key: new ValueKey<String>('FollowersList'),*/)
            ],

            /// Specify the page controller
            controller: _pageController,
            //onPageChanged: onPageChanged
        ),
        bottomNavigationBar: new TabBar(
            tabs: <Widget> [
              new Tab(
                  icon: new Icon(Icons.account_circle),
                  text: "profiles"
              ),
              new Tab(
                  icon: new Icon(Icons.rss_feed),
                  text: "feed"
              ),
              new Tab(
                  icon: new Icon(Icons.people),
                  text: "community"
              )
            ],
controller: _pageController,
            /// Will be used to scroll to the next page
            /// using the _pageController
            //onTap: navigationTapped,
            //currentIndex: _page
        )
    );
  }

//  void navigationTapped(int page){
//
//    // Animating to the page.
//    // You can use whatever duration and curve you like
//    _pageController.animateToPage(
//        page,
//        duration: const Duration(milliseconds: 300),
//        curve: Curves.ease
//    );
//  }

//  void onPageChanged(int page){
//    setState((){
//      this._page = page;
//    });
//  }

  @override
  void initState() {
    super.initState();
    _pageController = new TabController(length: 3, vsync: this);
//    _pageController = new PageController(
//      keepPage: true,
//    );
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
