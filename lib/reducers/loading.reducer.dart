import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/actions/loading.action.dart';

bool loadingReducer(bool state, BaseAction action) {
  if (action is LoadingAction) {
    return action.isLoading;
  }

  return state;
}
