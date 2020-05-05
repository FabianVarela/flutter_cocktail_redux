import 'package:flutter_cocktail_redux/actions/cocktail.action.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:redux/redux.dart';

class CocktailViewModel {
  final Function() getCategories;
  final List<CocktailCategory> categories;
  final CocktailCategory currentCategory;

  CocktailViewModel({
    this.getCategories,
    this.categories,
    this.currentCategory,
  });

  static CocktailViewModel fromStore(Store<AppState> store) {
    return CocktailViewModel(
      getCategories: () => store.dispatch(GetCategoriesAction()),
      categories: store.state.categories,
      currentCategory: store.state.currentCategory,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CocktailViewModel &&
          runtimeType == other.runtimeType &&
          categories == other.categories &&
          currentCategory == other.currentCategory;

  @override
  int get hashCode => 0;
}
