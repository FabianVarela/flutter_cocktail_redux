import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/alert.model.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/utils/themes.dart';
import 'package:flutter_cocktail_redux/view_model/alert.viewmodel.dart';
import 'package:flutter_cocktail_redux/views/cocktail_detail.ui.dart';
import 'package:flutter_cocktail_redux/views/cocktail_list.ui.dart';
import 'package:flutter_cocktail_redux/views/common/custom_loading.dart';
import 'package:flutter_cocktail_redux/views/ingredient_detail.ui.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class App extends StatefulWidget {
  App({Key key, this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Flutter Cocktails',
        initialRoute: '/',
        theme: Themes.getDarkTheme(Theme.of(context).textTheme),
        builder: (_, Widget child) => Scaffold(key: _scaffoldKey, body: child),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute<dynamic>(builder: (_) {
            return StoreConnector<AppState, AlertViewModel>(
              distinct: true,
              converter: AlertViewModel.fromStore,
              onWillChange: (_, AlertViewModel viewModel) {
                final Alert alert = viewModel.alert;

                if (alert != null &&
                    (alert.title.isNotEmpty && alert.message.isNotEmpty)) {
                  _showSnackBar(viewModel.alert.title, viewModel.alert.message,
                      viewModel.alert.type);
                  viewModel.hideAlert();
                }
              },
              builder: (__, AlertViewModel viewModel) {
                final bool isLoading = viewModel.isLoading ?? false;

                return Stack(
                  children: <Widget>[
                    _setRoute(settings.name, settings.arguments),
                    if (isLoading) CustomLoading(),
                  ],
                );
              },
            );
          });
        },
      ),
    );
  }

  Widget _setRoute(String routeName, [dynamic arguments]) {
    switch (routeName) {
      case '/':
        return CocktailListUI();
      case '/detail':
        return CocktailDetailUI(
          id: arguments['id'] as String,
          name: arguments['name'] as String,
          imageUrl: arguments['imageUrl'] as String,
        );
      case '/ingredient':
        return IngredientDetailUI(
          name: arguments['name'] as String,
        );
      default:
        return Container();
    }
  }

  void _showSnackBar(String title, String message, String type) {
    Future<void>.delayed(Duration(milliseconds: 100), () {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            '$title $message',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }
}
