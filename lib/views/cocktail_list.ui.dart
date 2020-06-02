import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:flutter_cocktail_redux/view_model/cocktail.viewmodel.dart';
import 'package:flutter_cocktail_redux/views/common/custom_drop_down.dart';
import 'package:flutter_cocktail_redux/views/common/custom_header.dart';
import 'package:flutter_cocktail_redux/views/common/custom_widget_shadow.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CocktailListUI extends StatefulWidget {
  @override
  _CocktailListUIState createState() => _CocktailListUIState();
}

class _CocktailListUIState extends State<CocktailListUI> {
  List<CocktailCategory> _categories;
  CocktailCategory _currentCategory;
  TextTheme _textTheme;

  @override
  void initState() {
    super.initState();
    _categories = <CocktailCategory>[];
    _currentCategory = CocktailCategory('');
  }

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;

    return StoreConnector<AppState, CocktailViewModel>(
      distinct: true,
      converter: CocktailViewModel.fromStore,
      onInitialBuild: (CocktailViewModel viewModel) =>
          viewModel.getCategories(),
      onWillChange: (_, CocktailViewModel viewModel) {
        _categories = viewModel.categories;
        _currentCategory = viewModel.currentCategory;
      },
      builder: (_, CocktailViewModel viewModel) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            child: Column(
              children: <Widget>[
                _setHeaders(),
                _setDropDown(viewModel),
                if (viewModel.cocktails.isNotEmpty) _setBody(viewModel),
                if (viewModel.cocktails.isEmpty) _setEmptyData(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _setHeaders() {
    return CustomHeader(
      leading: Icon(Icons.search),
      title: CustomWidgetShadow(
        child: Text(
          'Cocktails',
          textAlign: TextAlign.center,
          style: _textTheme.headline1.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      trailing: Icon(Icons.sync),
    );
  }

  Widget _setDropDown(CocktailViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomDropDownCategory(
        categories: _categories ?? <CocktailCategory>[],
        currentCategory: _currentCategory,
        setCurrentCategory: (CocktailCategory category) =>
            viewModel.setCocktailCategory(category),
        textStyle: _textTheme.bodyText2.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        hintText: 'Select a cocktail category',
        hintColor: Theme.of(context).hintColor,
      ),
    );
  }

  Widget _setBody(CocktailViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '${viewModel.currentCategory.category}: ${viewModel.cocktails.length}',
            style: _textTheme.bodyText1.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .7,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: viewModel.cocktails.length,
            itemBuilder: (_, int index) =>
                _setCocktailItem(viewModel.cocktails[index]),
          ),
        ),
      ],
    );
  }

  Widget _setCocktailItem(Cocktail item) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        onTap: () => _goToDetail(item),
        contentPadding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 16,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Hero(
            tag: 'cocktail_${item.id}',
            child: _setImage(item.image),
          ),
        ),
        title: Text(
          item.name,
          style: _textTheme.subtitle1.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Ref: ${item.id}',
          style: _textTheme.subtitle2.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _setImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (_, __, dynamic downloadProgress) {
        return CircularProgressIndicator(
          value: downloadProgress.progress,
          strokeWidth: 5,
        );
      },
      errorWidget: (_, __, ___) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).errorColor, size: 30),
        ],
      ),
    );
  }

  Widget _setEmptyData() {
    return Container(
      height: MediaQuery.of(context).size.height * .75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Icon(Icons.local_drink, size: 90),
          ),
          Text(
            'Oops! Empty data',
            style: _textTheme.headline1.copyWith(fontSize: 40),
          ),
        ],
      ),
    );
  }

  void _goToDetail(Cocktail item) {
    Navigator.of(context).pushNamed('/detail', arguments: <String, dynamic>{
      'id': item.id,
      'name': item.name,
      'imageUrl': item.image,
    });
  }
}
