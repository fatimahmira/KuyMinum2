import 'package:KuyMinum/config/view_state.dart';
import 'package:flutter/cupertino.dart';

class BaseProvider extends ChangeNotifier{
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState){
    _state = viewState;
    notifyListeners();
  }
}