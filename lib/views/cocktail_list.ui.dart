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
}
