import 'package:flutter_cocktail_redux/actions/cocktail.action.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:redux/redux.dart';

class CocktailDetailViewModel {
  final Function(String) setCocktailDetail;
  final List<CocktailDetail> cocktailDetails;

  CocktailDetailViewModel({
    this.setCocktailDetail,
    this.cocktailDetails,
  });

  static CocktailDetailViewModel fromStore(Store<AppState> store) {
    return CocktailDetailViewModel(
      setCocktailDetail: (String id) =>
          store.dispatch(SetCocktailNameAction(id: id)),
      cocktailDetails: store.state.cocktailDetails,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CocktailDetailViewModel &&
          runtimeType == other.runtimeType &&
          cocktailDetails == other.cocktailDetails;

  @override
  int get hashCode => 0;
}
