import 'package:get/get.dart';

class ModelPreferenci {
  final String title;
  Rx<bool> isSelected;

  ModelPreferenci({
    required this.title,
    required this.isSelected,
  });
}