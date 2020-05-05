import 'package:flutter_cocktail_redux/actions/category.action.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:redux/redux.dart';

class CocktailViewModel {
  final Function() getCategories;
  final List<CocktailCategory> categories;
  final CocktailCategory currentCategory;
  final Function(CocktailCategory) setCocktailCategory;

  CocktailViewModel({
    this.getCategories,
    this.categories,
    this.currentCategory,
    this.setCocktailCategory,
  });

  static CocktailViewModel fromStore(Store<AppState> store) {
    return CocktailViewModel(
      getCategories: () => store.dispatch(GetCategoriesAction()),
      categories: store.state.categories,
      currentCategory: store.state.currentCategory,
      setCocktailCategory: (CocktailCategory category) =>
          store.dispatch(SetCategoryAction(category: category)),
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
