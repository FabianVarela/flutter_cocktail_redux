import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/reducers/alert.reducer.dart';
import 'package:flutter_cocktail_redux/reducers/cocktail.reducer.dart';
import 'package:flutter_cocktail_redux/reducers/loading.reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    categories: categoriesReducer(state.categories, action),
    currentCategory: categoryReducer(state.currentCategory, action),
    cocktails: cocktailsReducer(state.cocktails, action),
    cocktailDetails: cocktailDetailReducer(state.cocktailDetails, action),
    alert: alertReducer(state.alert, action),
    isLoading: loadingReducer(state.isLoading, action),
  );
}
