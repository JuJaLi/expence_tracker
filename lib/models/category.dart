import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ExpenseCategory {
  foodStore,
  cinema,
  padel,
  jeans,
  flutterCourse,
}

extension CategoryExtension on ExpenseCategory {
  String get name {
    switch (this) {
      case ExpenseCategory.foodStore:
        return 'Food Store';
      case ExpenseCategory.cinema:
        return 'Cinema';
      case ExpenseCategory.padel:
        return 'Padel';
      case ExpenseCategory.jeans:
        return 'Jeans';
      case ExpenseCategory.flutterCourse:
        return 'Flutter Course';
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseCategory.foodStore:
        return FontAwesomeIcons.utensils;
      case ExpenseCategory.cinema:
        return FontAwesomeIcons.film;
      case ExpenseCategory.padel:
        return FontAwesomeIcons.tableTennisPaddleBall;
      case ExpenseCategory.jeans:
        return FontAwesomeIcons.shoppingBag;
      case ExpenseCategory.flutterCourse:
        return FontAwesomeIcons.code;
    }
  }
}
