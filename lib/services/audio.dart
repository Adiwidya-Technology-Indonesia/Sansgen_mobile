import 'dart:async';
import 'dart:developer';

import 'package:just_audio/just_audio.dart';

class AudioService {
  final player = AudioPlayer();

  Future playUrl() async {
    final duration = await player.setUrl('https://foo.com/bar.mp3');
    log(duration.toString(), name: 'duration');
  }

  Future play() async {
    await player.play();
  }

  Future pause() async {
    await player.pause();
  }

  Future stop() async {
    await player.stop();
  }

  Future jumToDuration(Duration duration) async {
    await player.seek(duration);
  }

  Future setSpeed(double speed) async {
    await player.setSpeed(speed);
  }

  Future setVolume(double volume) async {
    await player.setVolume(volume);
  }
}
