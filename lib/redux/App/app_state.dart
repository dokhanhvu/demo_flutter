import 'package:flutter_app/ui/widget/custom_appbar.dart';

class AppState {
  final AppBarState appBarState;

  AppState({this.appBarState});

  AppState copyWith({AppBarState appBarState}){
    return new AppState(
      appBarState: appBarState ?? new AppBarState()
    );
  }

}