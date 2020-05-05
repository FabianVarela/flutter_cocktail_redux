import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/models/cocktail.model.dart';

class CustomDropDownCategory extends StatefulWidget {
  CustomDropDownCategory({
    @required this.categories,
    @required this.currentCategory,
    @required this.setCurrentCategory,
    this.fontSize = 18,
    this.hintText = '',
  });

  final List<CocktailCategory> categories;
  final CocktailCategory currentCategory;
  final Function(CocktailCategory) setCurrentCategory;
  final double fontSize;
  final String hintText;

  @override
  _CustomDropDownCategoryState createState() => _CustomDropDownCategoryState();
}

class _CustomDropDownCategoryState extends State<CustomDropDownCategory> {
  List<DropdownMenuItem<CocktailCategory>> _categoriesList;

  @override
  Widget build(BuildContext context) {
    _categoriesList = _getStatusList();

    final DropdownMenuItem<CocktailCategory> item = _categoriesList.firstWhere(
      (DropdownMenuItem<CocktailCategory> s) =>
          s.value.category == widget.currentCategory.category,
      orElse: () => null,
    );

    return DropdownButtonHideUnderline(
      child: DropdownButton<CocktailCategory>(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Theme.of(context).disabledColor,
        ),
        iconSize: 18,
        hint: Text(
          widget.hintText,
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w700,
            fontSize: widget.fontSize,
          ),
        ),
        value: item?.value,
        items: _categoriesList,
        onChanged: widget.setCurrentCategory,
      ),
    );
  }

  List<DropdownMenuItem<CocktailCategory>> _getStatusList() {
    return widget.categories.map((CocktailCategory item) {
      return DropdownMenuItem<CocktailCategory>(
        value: item,
        child: Container(
          child: Text(
            item.category,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: widget.fontSize,
            ),
          ),
        ),
      );
    }).toList();
  }
}
