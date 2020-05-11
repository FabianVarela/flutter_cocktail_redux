import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(widget.name),
        ),
      ),
    );
  }
}
