import 'package:flutter_cocktail_redux/models/alert.model.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

class AppState {
  final List<CocktailCategory> categories;
  final CocktailCategory currentCategory;
  final List<Cocktail> cocktails;
  final List<CocktailDetail> cocktailDetails;
  final List<CocktailIngredient> cocktailIngredients;
  final Alert alert;
  final bool isLoading;

  AppState({
    this.categories,
    this.currentCategory,
    this.cocktails,
    this.cocktailDetails,
    this.cocktailIngredients,
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

      final List<Cocktail> cocktails = <Cocktail>[];
      if (json['cocktails'] != null) {
        json['cocktails'].forEach((dynamic item) {
          cocktails.add(Cocktail.fromJson(item));
        });
      }

      final List<CocktailDetail> cocktailDetails = <CocktailDetail>[];
      if (json['cocktailDetails'] != null) {
        json['cocktailDetails'].forEach((dynamic item) {
          cocktailDetails.add(CocktailDetail.fromJson(item));
        });
      }

      final List<CocktailIngredient> cocktailIngredients =
          <CocktailIngredient>[];
      if (json['cocktailIngredients'] != null) {
        json['cocktailIngredients'].forEach((dynamic item) {
          cocktailIngredients.add(CocktailIngredient.fromJson(item));
        });
      }

      return AppState(
        categories: categories,
        currentCategory: json['currentCategory'] != null
            ? CocktailCategory.fromJson(json['currentCategory'])
            : null,
        cocktails: cocktails,
        cocktailDetails: cocktailDetails,
        cocktailIngredients: cocktailIngredients,
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

    if (this.cocktails != null) {
      appStateData['cocktails'] =
          this.cocktails.map((Cocktail c) => c.toJson()).toList();
    }

    if (this.cocktailDetails != null) {
      appStateData['cocktailDetails'] =
          this.cocktailDetails.map((CocktailDetail cd) => cd.toJson()).toList();
    }

    if (this.cocktailIngredients != null) {
      appStateData['cocktailIngredients'] = this
          .cocktailIngredients
          .map((CocktailIngredient ci) => ci.toJson())
          .toList();
    }

    return appStateData;
  }

  AppState.initialState()
      : categories = <CocktailCategory>[],
        currentCategory = CocktailCategory(''),
        cocktails = <Cocktail>[],
        cocktailDetails = <CocktailDetail>[],
        cocktailIngredients = <CocktailIngredient>[],
        alert = Alert(),
        isLoading = false;
}
