import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({@required this.title, this.leading, this.trailing});

  final String title;
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
            if (leading != null) leading,
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
