import 'dart:ui';

import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor.withOpacity(.3),
        ),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
