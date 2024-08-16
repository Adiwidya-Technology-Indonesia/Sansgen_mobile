import 'package:get/get.dart';

import '../../../../model/on_boarding/referency.dart';

class ProfilePreferenciController extends GetxController {
  final listPreferences = <ModelPreferenci>[
    ModelPreferenci(id: 1, title: 'Bisnis', isSelected: false.obs),
    ModelPreferenci(id: 2, title: 'Pengembangan diri', isSelected: false.obs),
    ModelPreferenci(id: 3, title: 'Marketing & Sales', isSelected: false.obs),
    ModelPreferenci(id: 4, title: 'Sains', isSelected: false.obs),
    ModelPreferenci(id: 5, title: 'Filsafat', isSelected: false.obs),
    ModelPreferenci(id: 6, title: 'Agama', isSelected: false.obs),
    ModelPreferenci(id: 7, title: 'Politik', isSelected: false.obs),
    ModelPreferenci(id: 8, title: 'Sejarah', isSelected: false.obs),
  ];
}
