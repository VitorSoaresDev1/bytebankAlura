import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String nome, IconData icon) {
  if (widget is FeatureItem) {
    return widget.name == nome && widget.icon == icon;
  }
  return false;
}

bool textFieldByLabelTextMatcher(Widget widget, String name) {
  if (widget is TextField) {
    return widget.decoration.labelText == name;
  }
  return false;
}
