import 'package:flutter_cocktail_redux/models/alert.model.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

class AppState {
  final List<CocktailCategory> categories;
  final CocktailCategory currentCategory;
  final Alert alert;
  final bool isLoading;

  AppState({
    this.categories,
    this.currentCategory,
    this.alert,
    this.isLoading,
  });

  static AppState fromJson(dynamic json) {
    if (json != null) {
      final List<CocktailCategory> categories = <CocktailCategory>[];
      if (json['categories'] != null) {
        json['categories'].forEach((dynamic item) {
          categories.add(CocktailCategory.fromJson(item));
        });
      }

      return AppState(
        categories: categories,
        currentCategory: json['currentCategory'] != null
            ? CocktailCategory.fromJson(json['currentCategory'])
            : null,
        alert: json['alert'] != null ? Alert.fromJson(json['alert']) : null,
      );
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> appStateData = Map<String, dynamic>();

    if (this.categories != null) {
      appStateData['categories'] =
          this.categories.map((CocktailCategory cc) => cc.toJson()).toList();
    }

    if (this.currentCategory != null) {
      appStateData['currentCategory'] = this.currentCategory.toJson();
    }

    return appStateData;
  }

  AppState.initialState()
      : categories = <CocktailCategory>[],
        currentCategory = CocktailCategory(''),
        alert = Alert(),
        isLoading = false;
}
