import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';

import '../../../../services/audio.dart';


class AudioBookController extends GetxController {
  final audioPlayer = AudioService();

  final Rx<bool> stateAudio = false.obs;


  @override
  void onInit() async {
    const fileUri = 'https://teknodipani.com/storage/music-file/Y2meta.app%20-%20merindukanmu%20(cover)%20(128%20kbps).mp3';

    await audioPlayer.playUrl(fileUri);
    // await audioPlayer.playUrl('file:///home/yayat/Unduhan/Death%20Grips%20-%20Get%20Got.mp3');
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void onAudio() {
    log(stateAudio.value.toString(), name: "stateAudio.value");
    if (stateAudio.isFalse) {
      audioPlayer.play();
      audioPlayer.setVolume(100);
      stateAudio.value = !stateAudio.value;
    } else {
      audioPlayer.stop();
      audioPlayer.setVolume(0);
      stateAudio.value = !stateAudio.value;
    }
  }
}
