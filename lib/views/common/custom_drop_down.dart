import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

class CustomDropDownCategory extends StatelessWidget {
  CustomDropDownCategory({
    @required this.categories,
    @required this.currentCategory,
    @required this.setCurrentCategory,
    this.textStyle,
    this.hintText = '',
    this.hintColor = Colors.black,
  });

  final List<CocktailCategory> categories;
  final CocktailCategory currentCategory;
  final Function(CocktailCategory) setCurrentCategory;
  final TextStyle textStyle;
  final String hintText;
  final Color hintColor;

  List<DropdownMenuItem<CocktailCategory>> get _categoriesList =>
      _getStatusList();

  @override
  Widget build(BuildContext context) {
    final DropdownMenuItem<CocktailCategory> item = _categoriesList.firstWhere(
      (DropdownMenuItem<CocktailCategory> s) =>
          s.value.category == currentCategory.category,
      orElse: () => null,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(width: 1, color: hintColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CocktailCategory>(
          value: item?.value,
          hint: Text(hintText),
          style: textStyle,
          icon: Icon(Icons.keyboard_arrow_down, color: hintColor),
          iconSize: 25,
          items: _categoriesList,
          onChanged: setCurrentCategory,
        ),
      ),
    );
  }

  List<DropdownMenuItem<CocktailCategory>> _getStatusList() {
    return categories
        .map((CocktailCategory item) => DropdownMenuItem<CocktailCategory>(
              value: item,
              child: Text(item.category),
            ))
        .toList();
  }
}
