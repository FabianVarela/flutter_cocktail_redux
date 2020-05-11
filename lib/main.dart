import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cocktail_redux/app.dart';
import 'package:flutter_cocktail_redux/epics/cocktail.epic.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/reducers/main.reducer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);
  await DotEnv().load('.env');

  /// Create Persist
  final Persistor<AppState> persist = Persistor<AppState>(
    debug: true,
    storage: FlutterStorage(location: FlutterSaveLocation.documentFile),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  /// Epic Middleware
  final EpicMiddleware<AppState> epicMiddleware = EpicMiddleware<AppState>(
    combineEpics<AppState>(
      <Epic<AppState>>[serviceCocktailEpic],
    ),
  );

  /// Initial State with persist
  dynamic initialState;

  try {
    initialState = await persist.load();
  } catch (e) {
    initialState = null;
  }

  /// Create Store
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState.initialState(),
    middleware: <Middleware<AppState>>[
      persist.createMiddleware(),
      epicMiddleware,
    ],
  );

  runApp(App(store: store));
}
