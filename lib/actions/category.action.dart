import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

class GetCategoriesAction extends BaseAction {
  GetCategoriesAction();

  Map<String, String> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{
      'GetCategoriesAction': 'GetCategoriesAction',
    };
    return json;
  }
}

class CategoriesAction extends BaseAction {
  final List<CocktailCategory> categories;

  CategoriesAction({@required this.categories});

  Map<String, List<Map<String, dynamic>>> toJson() {
    final Map<String, List<Map<String, dynamic>>> json =
        Map<String, List<Map<String, dynamic>>>();

    json['CocktailCategoriesAction'] =
        this.categories.map((CocktailCategory cc) => cc.toJson());

    return json;
  }
}

class SetCategoryAction extends BaseAction {
  final CocktailCategory category;

  SetCategoryAction({@required this.category});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{
      'SetCategoryAction': this.category.toJson(),
    };

    return json;
  }
}
