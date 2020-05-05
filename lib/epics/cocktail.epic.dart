import 'dart:convert';

import 'package:flutter_cocktail_redux/actions/alert.action.dart';
import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/actions/category.action.dart';
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
        yield await getCategoryList(apiClient);
        yield LoadingAction(isLoading: false);
        break;
    }
  }
}

Future<BaseAction> getCategoryList(ApiClient api) async {
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
      title: 'An error has ocurred',
      message: 'Try again later',
    ));
  }
}
