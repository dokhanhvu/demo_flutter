import 'package:flutter/material.dart';

class AppBarState{
  int level;
  VoidCallback backSpaceHandler;

  AppBarState({this.level : 0, this.backSpaceHandler});
}

class CustomAppbar extends StatefulWidget {

  @override
  _CustomAppbarState createState() => _CustomAppbarState();

  static _CustomAppbarState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(_InheritedAppbarState) as _InheritedAppbarState).data;
  }

}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: null,
      ),
    );
  }
}

class _InheritedAppbarState extends InheritedWidget{

  final _CustomAppbarState data;

  _InheritedAppbarState({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}


