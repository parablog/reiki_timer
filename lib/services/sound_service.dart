import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class SoundService extends GetxService {
  static AudioCache player = AudioCache(prefix: 'assets/sounds/');
  // final CountdownController _controller = new CountdownController();

  Future<SoundService> init() async {
    player.load('bell.mp3');
    return this;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void play() {
    player.play('bell.mp3', stayAwake: true);
  }
}
