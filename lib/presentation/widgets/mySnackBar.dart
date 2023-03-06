import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackBar(
    {required BuildContext context,
    required String content,
    Color backgroundColor = Colors.grey}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        content,
        style: TextStyle(color: Colors.white),
      )));
}
