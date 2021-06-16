import 'dart:async';

import 'package:get/get.dart';
import 'package:reiki_app/services/sound_service.dart';
// import 'package:reiki_app/widgets/timer_countdown.dart';
import 'package:wakelock/wakelock.dart';

class HomeController extends GetxController {
  final _soundService = Get.find<SoundService>();

  // reactives
  var positions = 10.obs;
  var minutes = 3.obs;

  var started = false.obs;
  var paused = false.obs;

  // state
  var secondsElapsed = 0.obs;
  var currentPosition = 0.obs;

  // just counter stuff
  Timer? _timer;

  @override
  void onInit() {
    // millisecondsCount = 0;
    secondsElapsed(0);
    currentPosition(0);
    super.onInit();
  }

  incrementPosition() => positions++;
  decrementPosition() => (positions() - 1) == 0 ? positions : positions--;
  incrementMinutes() => minutes++;
  decrementMinutes() => (minutes() - 1) == 0 ? minutes : minutes--;

  int get seconds => minutes() * 60;
  int get total => positions() * seconds;
  int get elapsed => secondsElapsed() + (currentPosition() * seconds);

  void startStop() {
    if (started())
      stop();
    else
      start();
  }

  void stop() {
    Wakelock.disable();

    _stopTimer();
    started(false);

    // reset state
    secondsElapsed(0);
    currentPosition(0);
  }

  void start() {
    started(true);
    _startTimer();

    Wakelock.enable();
  }

  void playSound() async {
    _soundService.play();
  }

  double left() {
    var value = ((total - elapsed)) / total;
    return 1 - value;
  }

  void tick() {
    secondsElapsed++;

    print('tick $secondsElapsed == $seconds. total: $total, elapsed: $elapsed');

    if (secondsElapsed() == seconds) {
      playSound();
      moveToNextPosition();

      if (finished()) {
        stop();
        Future.delayed(Duration(seconds: 1), () => playSound());
      } else {
        secondsElapsed(0);
        restartCounter();
      }
    }
  }

  bool finished() {
    return currentPosition.value == positions.value;
  }

  void moveToNextPosition() {
    currentPosition++;
  }

  void restartCounter() {
    _stopTimer();
    _startTimer();
  }

  void pause() {
    if (paused()) {
      _startTimer();
      paused(false);
    } else {
      _stopTimer();
      paused(true);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) => tick());
  }

  void _stopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }
}
