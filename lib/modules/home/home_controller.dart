import 'package:get/get.dart';
import 'package:reiki_app/services/sound_service.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:wakelock/wakelock.dart';

class HomeController extends GetxController {
  final _soundService = Get.find<SoundService>();
  final countdownController = new CountdownController();

  var positions = 10.obs;
  var minutes = 3.obs;
  var started = false.obs;
  var elapsed = 0;
  var position = 0;

  // todo: remove me
  final count1 = 0.obs;
  final count2 = 0.obs;
  int get sum => count1.value + count2.value;

  @override
  void onInit() {
    super.onInit();
  }

  incrementPosition() => positions++;
  decrementPosition() => (positions() - 1) == 0 ? positions : positions--;
  incrementMinutes() => minutes++;
  decrementMinutes() => (minutes() - 1) == 0 ? minutes : minutes--;

  void startStop() {
    if (started())
      stop();
    else
      start();
  }

  void stop() {
    elapsed = 0;
    position = 0;
    started(false);
    Wakelock.disable();
  }

  void start() {
    elapsed = 0;
    position = 0;
    started(true);
    Wakelock.enable();
  }

  void play() async {
    _soundService.play();
  }

  double left() {
    var total = positions() * seconds;
    var value = ((total - elapsed)) / total;
    // print('HomeController.left value -> ${value}');
    return 1 - value; // - 0.10;
  }

  int get seconds => minutes() * 60;

  void tick() {
    elapsed++;
  }

  void addToCount1() => count1.value++;
  void addToCount2() => count2.value++;

  bool finished() {
    return position == positions.value;
  }

  void move() {
    position++;
  }

  void restartCounter() {
    countdownController.restart();
  }
}
