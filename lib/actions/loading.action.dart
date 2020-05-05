import 'package:flutter/material.dart';
import 'package:flutter_cocktail_redux/actions/base.action.dart';

class LoadingAction extends BaseAction {
  final bool isLoading;

  LoadingAction({@required this.isLoading});

  Map<String, bool> toJson() {
    final Map<String, bool> json = <String, bool>{
      'LoadingAction': isLoading,
    };

    return json;
  }
}
