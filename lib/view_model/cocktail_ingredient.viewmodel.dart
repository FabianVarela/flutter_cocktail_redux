import 'package:flutter_cocktail_redux/actions/cocktail.action.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:redux/redux.dart';

class CocktailIngredientViewModel {
  final Function(String) setCocktailIngredients;
  final List<CocktailIngredient> cocktailIngredients;

  CocktailIngredientViewModel({
    this.setCocktailIngredients,
    this.cocktailIngredients,
  });

  static CocktailIngredientViewModel fromStore(Store<AppState> store) {
    return CocktailIngredientViewModel(
      setCocktailIngredients: (String name) =>
          store.dispatch(SetCocktailIngredientAction(name: name)),
      cocktailIngredients: store.state.cocktailIngredients,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CocktailIngredientViewModel &&
          runtimeType == other.runtimeType &&
          cocktailIngredients == other.cocktailIngredients;

  @override
  int get hashCode => 0;
}
