import 'dart:ui';

import 'package:flutter/material.dart';

class CustomWidgetShadow extends StatelessWidget {
  CustomWidgetShadow({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: child,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: child,
          ),
        ],
      ),
    );
  }
}
