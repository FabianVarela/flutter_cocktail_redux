import 'package:flutter/cupertino.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:redux/redux.dart';

class AlertViewModel {
  final bool isLoading;

  AlertViewModel({@required this.isLoading});

  static AlertViewModel fromStore(Store<AppState> store) {
    return AlertViewModel(
      isLoading: store.state.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading;

  @override
  int get hashCode => 0;
}
