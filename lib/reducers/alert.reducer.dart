import 'package:flutter_cocktail_redux/actions/alert.action.dart';
import 'package:flutter_cocktail_redux/models/alert.model.dart';
import 'package:redux/redux.dart';

Alert showWarningAlert(Alert state, AlertWarningAction action) {
  return Alert(
    type: 'warning',
    title: action.alert.title,
    message: action.alert.message,
  );
}

Alert showErrorAlert(Alert state, AlertErrorAction action) {
  return Alert(
    type: 'error',
    title: action.alert.title,
    message: action.alert.message,
  );
}

final Reducer<Alert> alertReducer = combineReducers<Alert>(
  <Reducer<Alert>>[
    TypedReducer<Alert, AlertWarningAction>(showWarningAlert),
    TypedReducer<Alert, AlertErrorAction>(showErrorAlert),
  ],
);
