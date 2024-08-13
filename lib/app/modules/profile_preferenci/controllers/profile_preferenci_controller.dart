import 'package:get/get.dart';

import '../../../../model/on_boarding/referency.dart';

class ProfilePreferenciController extends GetxController {
  final listPreferences = <ModelPreferenci>[
    ModelPreferenci(title: 'Bisnis', isSelected: false.obs),
    ModelPreferenci(title: 'Pengembangan diri', isSelected: false.obs),
    ModelPreferenci(title: 'Marketing & Sales', isSelected: false.obs),
    ModelPreferenci(title: 'Sains', isSelected: false.obs),
    ModelPreferenci(title: 'Filsafat', isSelected: false.obs),
    ModelPreferenci(title: 'Agama', isSelected: false.obs),
    ModelPreferenci(title: 'Politik', isSelected: false.obs),
    ModelPreferenci(title: 'Sejarah', isSelected: false.obs),
  ];
}
