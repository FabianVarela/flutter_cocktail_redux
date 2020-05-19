import 'package:flutter/cupertino.dart';
import 'package:flutter_cocktail_redux/actions/alert.action.dart';
import 'package:flutter_cocktail_redux/models/alert.model.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:redux/redux.dart';

class AlertViewModel {
  final bool isLoading;
  final Alert alert;
  final Function() hideAlert;

  AlertViewModel({
    @required this.isLoading,
    @required this.alert,
    this.hideAlert,
  });

  static AlertViewModel fromStore(Store<AppState> store) {
    return AlertViewModel(
      isLoading: store.state.isLoading,
      alert: store.state.alert,
      hideAlert: () => store.dispatch(AlertGenericAction(Alert())),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          alert == other.alert;

  @override
  int get hashCode => 0;
}
