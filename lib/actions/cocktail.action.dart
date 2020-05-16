import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

class CocktailsAction extends BaseAction {
  final List<Cocktail> cocktails;

  CocktailsAction({@required this.cocktails});

  Map<String, List<Map<String, dynamic>>> toJson() {
    final Map<String, List<Map<String, dynamic>>> json =
        Map<String, List<Map<String, dynamic>>>();

    json['CocktailsAction'] = this.cocktails.map((Cocktail c) => c.toJson());

    return json;
  }
}

class SetCocktailNameAction extends BaseAction {
  final String id;

  SetCocktailNameAction({@required this.id});

  Map<String, String> toJson() {
    final Map<String, String> json = <String, String>{
      'SetCocktailNameAction': this.id,
    };

    return json;
  }
}

class CocktailDetailsAction extends BaseAction {
  final List<CocktailDetail> cocktailDetails;

  CocktailDetailsAction({@required this.cocktailDetails});

  Map<String, List<Map<String, dynamic>>> toJson() {
    final Map<String, List<Map<String, dynamic>>> json =
        Map<String, List<Map<String, dynamic>>>();

    json['CocktailDetailsAction'] =
        this.cocktailDetails.map((CocktailDetail cd) => cd.toJson());

    return json;
  }
}

class SetCocktailIngredientAction extends BaseAction {
  final String name;

  SetCocktailIngredientAction({@required this.name});

  Map<String, String> toJson() {
    final Map<String, String> json = <String, String>{
      'SetIngredientAction': this.name,
    };

    return json;
  }
}

class CocktailIngredientsAction extends BaseAction {
  final List<CocktailIngredient> cocktailIngredients;

  CocktailIngredientsAction({@required this.cocktailIngredients});

  Map<String, List<Map<String, dynamic>>> toJson() {
    final Map<String, List<Map<String, dynamic>>> json =
        Map<String, List<Map<String, dynamic>>>();

    json['CocktailIngredientsAction'] =
        this.cocktailIngredients.map((CocktailIngredient ci) => ci.toJson());

    return json;
  }
}
