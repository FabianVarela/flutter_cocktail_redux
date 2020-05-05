import 'package:flutter_cocktail_redux/actions/base.action.dart';
import 'package:flutter_cocktail_redux/models/alert.model.dart';

class AlertWarningAction extends BaseAction {
  final Alert alert;

  AlertWarningAction(this.alert);

  Map<String, String> toJson() {
    final Map<String, String> json = <String, String>{
      'WarningAction': alert.toString(),
    };

    return json;
  }
}

class AlertErrorAction extends BaseAction {
  final Alert alert;

  AlertErrorAction(this.alert);

  Map<String, String> toJson() {
    final Map<String, String> json = <String, String>{
      'ErrorAction': alert.toString(),
    };

    return json;
  }
}
