import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({@required this.title, this.leading, this.trailing});

  final Widget title;
  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (leading != null)
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: leading,
                ),
              ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.topCenter,
                child: title,
              ),
            ),
            if (trailing != null)
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: trailing,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
