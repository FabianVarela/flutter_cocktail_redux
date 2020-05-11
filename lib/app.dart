import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/view_model/alert.viewmodel.dart';
import 'package:flutter_cocktail_redux/views/cocktail_detail.ui.dart';
import 'package:flutter_cocktail_redux/views/cocktail_list.ui.dart';
import 'package:flutter_cocktail_redux/views/common/custom_loading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class App extends StatefulWidget {
  App({Key key, this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/list',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<dynamic>(builder: (BuildContext ctx) {
          return StoreProvider<AppState>(
            store: widget.store,
            child: StoreConnector<AppState, AlertViewModel>(
              distinct: true,
              converter: AlertViewModel.fromStore,
              builder: (BuildContext context, AlertViewModel viewModel) {
                final bool isLoading = viewModel.isLoading ?? false;

                return Stack(
                  children: <Widget>[
                    _setRoute(settings.name, settings.arguments),
                    if (isLoading) CustomLoading(),
                  ],
                );
              },
            ),
          );
        });
      },
    );
  }

  Widget _setRoute(String routeName, [dynamic arguments]) {
    switch (routeName) {
      case '/list':
        return CocktailListUI();
      case '/detail':
        return CocktailDetailUI(
          id: arguments['id'] as String,
          name: arguments['name'] as String,
          imageUrl: arguments['imageUrl'] as String,
        );
      default:
        return Container();
    }
  }
}
