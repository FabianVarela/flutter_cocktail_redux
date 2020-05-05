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
