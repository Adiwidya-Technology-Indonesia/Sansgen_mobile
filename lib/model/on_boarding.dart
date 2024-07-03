import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelOnBoarding {
  final String title;
  final String titleAppBar;
  final String titleButton;
  final Widget page;

  ModelOnBoarding({
    required this.title,
    required this.titleAppBar,
    required this.titleButton,
    required this.page,
  });
}

class ModelGender {
  final String title;
  final String imageAssets;

  ModelGender({
    required this.title,
    required this.imageAssets,
  });
}

class ModelPreferenci {
  final String title;
  Rx<bool> isSelected;

  ModelPreferenci({
    required this.title,
    required this.isSelected,
  });
}
