import 'dart:convert';

import 'package:flutter_cocktail_redux/actions/alert.action.dart';
import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/actions/category.action.dart';
import 'package:flutter_cocktail_redux/actions/cocktail.action.dart';
import 'package:flutter_cocktail_redux/actions/loading.action.dart';
import 'package:flutter_cocktail_redux/api/api_client.dart';
import 'package:flutter_cocktail_redux/models/alert.model.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:http/http.dart';
import 'package:redux_epics/redux_epics.dart';

Stream<dynamic> serviceCocktailEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) async* {
  final ApiClient apiClient = ApiClient();

  await for (final dynamic action in actions) {
    switch (action.runtimeType) {
      case GetCategoriesAction:
        yield LoadingAction(isLoading: true);
        yield await _getCategoryList(apiClient);
        yield LoadingAction(isLoading: false);
        break;
      case SetCategoryAction:
        yield LoadingAction(isLoading: true);
        yield await _getCocktailList(apiClient, action.category.category);
        yield LoadingAction(isLoading: false);
        break;
      case SetCocktailNameAction:
        yield LoadingAction(isLoading: true);
        yield await _getCocktailDetail(apiClient, action.id);
        yield LoadingAction(isLoading: false);
        break;
      case SetCocktailIngredientAction:
        yield LoadingAction(isLoading: true);
        yield await _getCocktailIngredient(apiClient, action.name);
        yield LoadingAction(isLoading: false);
        break;
    }
  }
}

Future<BaseAction> _getCategoryList(ApiClient api) async {
  try {
    final Response response = await api.getCategoryList();
    final dynamic decodedResponse = jsonDecode(response.body);
    final List<CocktailCategory> categories = <CocktailCategory>[];

    if (decodedResponse['drinks'] is List<dynamic>) {
      for (final dynamic item in decodedResponse['drinks'])
        categories.add(CocktailCategory.fromJson(item));
    }

    return CategoriesAction(categories: categories);
  } catch (_) {
    return AlertErrorAction(Alert(
      type: 'error',
      title: 'An error has ocurred: ',
      message: 'Error to get category list. Try again later',
    ));
  }
}

Future<BaseAction> _getCocktailList(ApiClient api, String category) async {
  try {
    final Response response = await api.getDrinksByCategory(category);

    final dynamic decodedResponse = jsonDecode(response.body);
    final List<Cocktail> cocktails = <Cocktail>[];

    if (decodedResponse['drinks'] is List<dynamic>) {
      for (final dynamic item in decodedResponse['drinks'])
        cocktails.add(Cocktail.fromJson(item));
    }

    return CocktailsAction(cocktails: cocktails);
  } catch (_) {
    return AlertErrorAction(Alert(
      type: 'error',
      title: 'An error has ocurred: ',
      message: 'Error to get cocktail list. Try again later',
    ));
  }
}

Future<BaseAction> _getCocktailDetail(ApiClient api, String id) async {
  try {
    final Response response = await api.getDetailDrink(id);

    final dynamic decodedResponse = jsonDecode(response.body);
    final List<CocktailDetail> cocktailDetails = <CocktailDetail>[];

    if (decodedResponse['drinks'] is List<dynamic>) {
      for (final dynamic item in decodedResponse['drinks'])
        cocktailDetails.add(CocktailDetail.fromJson(item));
    }

    return CocktailDetailsAction(cocktailDetails: cocktailDetails);
  } catch (_) {
    return AlertErrorAction(Alert(
      type: 'error',
      title: 'An error has ocurred: ',
      message: 'Error to get cocktail detail. Try again later',
    ));
  }
}

Future<BaseAction> _getCocktailIngredient(ApiClient api, String name) async {
  try {
    final Response response = await api.getDrinkIngredient(name);

    final dynamic decodedResponse = jsonDecode(response.body);
    final List<CocktailIngredient> cocktailIngredients = <CocktailIngredient>[];

    if (decodedResponse['ingredients'] is List<dynamic>) {
      for (final dynamic item in decodedResponse['ingredients'])
        cocktailIngredients.add(CocktailIngredient.fromJson(item));
    }

    return CocktailIngredientsAction(cocktailIngredients: cocktailIngredients);
  } catch (_) {
    return AlertErrorAction(Alert(
      type: 'error',
      title: 'An error has ocurred: ',
      message: 'Error to get ingredient detail. Try again later',
    ));
  }
}
