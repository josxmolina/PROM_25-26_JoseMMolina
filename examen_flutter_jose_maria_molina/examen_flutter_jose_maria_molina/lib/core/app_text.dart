import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jose_maria_molina/core/app_colors.dart';

class AppText {
  TextStyle normal = TextStyle(fontSize: 20, color: AppColorsLight().text);
  TextStyle normalGrande = TextStyle(
    fontSize: 25,
    color: AppColorsLight().text,
  );
  TextStyle grande = TextStyle(fontSize: 30, color: AppColorsLight().text);
  TextStyle cabecera = TextStyle(
    fontSize: 60,
    color: AppColorsLight().text,
    fontWeight: FontWeight.bold,
  );
}
