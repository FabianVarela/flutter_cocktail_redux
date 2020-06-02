import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:flutter_cocktail_redux/view_model/cocktail_ingredient.viewmodel.dart';
import 'package:flutter_cocktail_redux/views/common/custom_header.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

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
              _setCardDescription(),
            ],
          ),
        );
      },
    );
  }

  Widget _setHeader() {
    return CustomHeader(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.blueGrey,
        ),
      ),
      title: Text(
        widget.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Icon(
        Icons.share,
        color: Colors.blueGrey,
      ),
    );
  }

  Widget _setBody() {
    if (_cocktailIngredient == null) {
      return _setEmptyData();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(20, 110, 20, 0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _setMainData()),
              Expanded(child: _setImage()),
            ],
          ),
        ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _setTitleMessage('Ref.: ', _cocktailIngredient.id),
              _setTitleMessage('Name: ', _cocktailIngredient.name),
              _setTitleMessage('Type: ', _cocktailIngredient.type ?? 'No type'),
              _setTitleMessage(
                  'Alcholic: ', _cocktailIngredient.isAlcohol ? 'Yes' : 'No'),
              _setTitleMessage('Vol %: ', '${_cocktailIngredient.volume}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setTitleMessage(String title, String message) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.muli(
          fontSize: 16,
          color: Colors.blueGrey,
        ),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: message,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ],
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                  strokeWidth: 6,
                ),
              );
            },
            errorWidget: (_, __, ___) => Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                    Text(
                      'Error to load image',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _setCardDescription() {
    if (_cocktailIngredient == null) {
      return Container();
    }

    return Positioned(
      top: 430,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 10)],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Text(
            _cocktailIngredient.description ?? 'Description not found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}
