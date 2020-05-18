import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/app_state.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';
import 'package:flutter_cocktail_redux/view_model/cocktail.viewmodel.dart';
import 'package:flutter_cocktail_redux/views/common/custom_drop_down.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CocktailListUI extends StatefulWidget {
  @override
  _CocktailListUIState createState() => _CocktailListUIState();
}

class _CocktailListUIState extends State<CocktailListUI> {
  List<CocktailCategory> _categories;
  CocktailCategory _currentCategory;

  @override
  void initState() {
    super.initState();
    _categories = <CocktailCategory>[];
    _currentCategory = CocktailCategory('');
  }

  @override
  Widget build(BuildContext context) {
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              Text(
                'Cocktails',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                icon: Icon(Icons.sync),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _setDropDown(CocktailViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: CustomDropDownCategory(
          categories: _categories ?? <CocktailCategory>[],
          currentCategory: _currentCategory,
          setCurrentCategory: (CocktailCategory category) =>
              viewModel.setCocktailCategory(category),
          fontSize: 16,
          hintText: 'Select a cocktail category',
        ),
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
            style: TextStyle(
              fontSize: 30,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .7,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: viewModel.cocktails.length,
            itemBuilder: (_, int index) {
              final Cocktail item = viewModel.cocktails[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  onTap: () => _goToDetail(item),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 16,
                  ),
                  leading: Hero(
                    tag: 'cocktail_${item.id}',
                    child: CachedNetworkImage(
                      imageUrl: item.image,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (_, __, dynamic downloadProgress) {
                        return CircularProgressIndicator(
                          value: downloadProgress.progress,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                        );
                      },
                      errorWidget: (_, __, ___) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                  subtitle: Text(
                    'Ref: ${item.id}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
            child: Icon(
              Icons.local_drink,
              size: 90,
              color: Colors.blueGrey,
            ),
          ),
          Text(
            'Oops! Empty data',
            style: TextStyle(
              fontSize: 40,
              color: Colors.blueGrey,
            ),
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
