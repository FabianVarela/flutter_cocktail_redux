import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cocktail_redux/epics/cocktail.epic.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/reducers/main.reducer.dart';
import 'package:flutter_cocktail_redux/views/cocktail_list.ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  await DotEnv().load('.env');

  final Persistor<AppState> persist = Persistor<AppState>(
    debug: true,
    storage: FlutterStorage(location: FlutterSaveLocation.documentFile),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  final Epic<AppState> epics = combineEpics<AppState>(
    <Epic<AppState>>[serviceCocktailEpic],
  );

  final EpicMiddleware<AppState> epicMiddleware =
      EpicMiddleware<AppState>(epics);

  dynamic initialState;

  try {
    initialState = await persist.load();
  } catch (e) {
    initialState = null;
  }

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState.initialState(),
    middleware: <Middleware<AppState>>[
      persist.createMiddleware(),
      epicMiddleware,
    ],
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CocktailListUI(),
      ),
    );
  }
}
