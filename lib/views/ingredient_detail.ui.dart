import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:flutter_cocktail_redux/view_model/cocktail_ingredient.viewmodel.dart';
import 'package:flutter_redux/flutter_redux.dart';

class IngredientDetailUI extends StatefulWidget {
  IngredientDetailUI({@required this.name});

  final String name;

  @override
  _IngredientDetailState createState() => _IngredientDetailState();
}

class _IngredientDetailState extends State<IngredientDetailUI> {
  CocktailIngredient _cocktailIngredient;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CocktailIngredientViewModel>(
      distinct: true,
      converter: CocktailIngredientViewModel.fromStore,
      onInitialBuild: (CocktailIngredientViewModel viewModel) =>
          viewModel.setCocktailIngredients(widget.name),
      onWillChange: (_, CocktailIngredientViewModel viewModel) =>
          _cocktailIngredient = viewModel.cocktailIngredients[0],
      builder: (_, CocktailIngredientViewModel viewModel) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              _setBody(),
              _setHeader(),
            ],
          ),
        );
      },
    );
  }

  Widget _setHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            ),
            Expanded(
              child: Text(
                widget.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setBody() {
    if (_cocktailIngredient == null) {
      return _setEmptyData();
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: _setMainData()),
                Expanded(child: _setImage()),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: _setCardDescription(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setEmptyData() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Icon(
              Icons.warning,
              color: Colors.blueGrey,
              size: 100,
            ),
          ),
          Text(
            'No exists data to ${widget.name}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _setMainData() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(_cocktailIngredient.id),
              Text(_cocktailIngredient.name),
              Text(_cocktailIngredient.type ?? 'No type'),
              Text('${_cocktailIngredient.isAlcohol}'),
              Text('${_cocktailIngredient.volume}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setImage() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Container(
          height: 250,
          child: CachedNetworkImage(
            imageUrl: _cocktailIngredient.image,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (_, __, dynamic downloadProgress) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  strokeWidth: 6,
                ),
              );
            },
            errorWidget: (_, __, ___) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error, color: Colors.red),
                  Text(
                    'Error to load the image',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _setCardDescription() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Text(
          _cocktailIngredient.description ?? 'Description not found',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
