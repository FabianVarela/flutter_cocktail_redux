import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:flutter_cocktail_redux/view_model/cocktail_detail.viewmodel.dart';
import 'package:flutter_cocktail_redux/views/common/custom_clipper.dart';
import 'package:flutter_cocktail_redux/views/common/custom_header.dart';
import 'package:flutter_cocktail_redux/views/common/custom_widget_shadow.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CocktailDetailUI extends StatefulWidget {
  CocktailDetailUI({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
  });

  final String id;
  final String name;
  final String imageUrl;

  @override
  _CocktailDetailUIState createState() => _CocktailDetailUIState();
}

class _CocktailDetailUIState extends State<CocktailDetailUI> {
  CocktailDetail _cocktailDetail;
  TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;

    return StoreConnector<AppState, CocktailDetailViewModel>(
      distinct: true,
      converter: CocktailDetailViewModel.fromStore,
      onInitialBuild: (CocktailDetailViewModel viewModel) =>
          Future<void>.delayed(Duration(milliseconds: 150),
              () => viewModel.setCocktailDetail(widget.id)),
      onWillChange: (_, CocktailDetailViewModel viewModel) =>
          _cocktailDetail = viewModel.cocktailDetails[0],
      builder: (_, CocktailDetailViewModel viewModel) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
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
    return CustomHeader(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: CustomWidgetShadow(
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      title: CustomWidgetShadow(
        child: Text(
          widget.name,
          textAlign: TextAlign.center,
          style: _textTheme.headline1.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      trailing: CustomWidgetShadow(child: Icon(Icons.share)),
    );
  }

  Widget _setBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'cocktail_${widget.id}',
            child: ClipPath(
              clipper: CocktailWaveClipper(),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_cocktailDetail == null) _setEmptyData(),
          if (_cocktailDetail != null) _setBodyData(),
        ],
      ),
    );
  }

  Widget _setEmptyData() {
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Icon(Icons.warning, size: 60),
          ),
          Text(
            'Data not found for ${widget.name}',
            textAlign: TextAlign.center,
            style: _textTheme.headline1.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _setBodyData() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          _setCardMain(),
          _setIngredientList(),
          _setCardInstructions(),
        ],
      ),
    );
  }

  Widget _setCardMain() {
    return Card(
      elevation: 10,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    _cocktailDetail.name,
                    style: _textTheme.bodyText1.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  _cocktailDetail.category,
                  style: _textTheme.bodyText1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Alcoholic',
                      style: _textTheme.bodyText1.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _cocktailDetail.isAlcoholic ? 'Yes' : 'No',
                      style: _textTheme.bodyText1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Glass',
                      style: _textTheme.bodyText1.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _cocktailDetail.glass,
                      style: _textTheme.bodyText1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _setIngredientList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Ingredients',
              style: _textTheme.headline1.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 120,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: _cocktailDetail.ingredients.length,
              itemBuilder: (_, int index) {
                final String ingredient = _cocktailDetail.ingredients[index];
                final String measure = _cocktailDetail.measures[index];

                if ((ingredient != null && ingredient.trim().isNotEmpty) ||
                    (measure != null && measure.trim().isNotEmpty)) {
                  return GestureDetector(
                    onTap: () => _goToIngredient(ingredient),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              ingredient,
                              textAlign: TextAlign.center,
                              style: _textTheme.subtitle1.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              measure ?? '',
                              textAlign: TextAlign.center,
                              style: _textTheme.subtitle2.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _setCardInstructions() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Instructions',
              style: _textTheme.headline1.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              _cocktailDetail.instruction.isNotEmpty
                  ? _cocktailDetail.instruction
                  : 'No instructions found',
              style: _textTheme.bodyText1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToIngredient(String ingredient) {
    Navigator.of(context).pushNamed('/ingredient', arguments: <String, dynamic>{
      'name': ingredient,
    });
  }
}
