import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/actions/category.action.dart';
import 'package:flutter_cocktail_redux/actions/cocktail.action.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

List<CocktailCategory> categoriesReducer(
    List<CocktailCategory> state, BaseAction action) {
  if (action is CategoriesAction) {
    return action.categories;
  }

  return state;
}

CocktailCategory categoryReducer(CocktailCategory state, BaseAction action) {
  if (action is SetCategoryAction) {
    return action.category;
  }

  return state;
}

List<Cocktail> cocktailsReducer(List<Cocktail> state, BaseAction action) {
  if (action is CocktailsAction) {
    return action.cocktails;
  }

  return state;
}

List<CocktailDetail> cocktailDetailReducer(
    List<CocktailDetail> state, BaseAction action) {
  if (action is CocktailDetailsAction) {
    return action.cocktailDetails;
  }

  return state;
}

List<CocktailIngredient> cocktailIngredientReducer(
    List<CocktailIngredient> state, BaseAction action) {
  if (action is CocktailIngredientsAction) {
    return action.cocktailIngredients;
  }

  return state;
}
