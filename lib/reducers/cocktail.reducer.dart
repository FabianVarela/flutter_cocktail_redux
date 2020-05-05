import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/actions/cocktail.action.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

List<CocktailCategory> categoriesReducer(
    List<CocktailCategory> state, BaseAction action) {
  if (action is CocktailCategoriesAction) {
    return action.categories;
  }

  return state;
}

CocktailCategory categoryReducer(CocktailCategory state, BaseAction action) {
  if (action is GetCategoryAction) {
    return action.category;
  }

  return state;
}
