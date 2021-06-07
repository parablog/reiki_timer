import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reiki_app/modules/home/home_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class HomePage extends GetView<HomeController> {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    // final HomeController c = Get.put(HomeController());

    return Scaffold(
      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/background.jpg',
              ),
            ),
          ),
          // height: 350.0,
        ),
        Container(
          // height: 350.0,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              stops: [0.3, 0.9],
              colors: <Color>[
                Color(0x8A02102D),
                Color(0x41D06E04),
              ],
            ),
          ),
        ),
        buildBody(),
      ]),
      //buildBody(buttonStyle, labelTextStyle, counterTextStyle),
      floatingActionButton: FloatingActionButton(
        child: Obx(
          () => controller.started() ? Icon(Icons.stop) : Icon(Icons.play_arrow),
        ),
        onPressed: controller.startStop,
      ),
    );
  }

  Container buildBody() {
    return Container(
      child: GetX<HomeController>(
        builder: (controller) => controller.started() ? buildCounter() : buildConfig(),
      ),
    );
  }

  Column buildConfig() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
          child: GetX<HomeController>(
            builder: (controller) => !controller.started() ? buildPresets(labelTextStyle) : Container(),
          ),
        ),
        GetX<HomeController>(
          builder: (controller) => buildPositions(controller, buttonStyle, labelTextStyle),
        ),
        GetX<HomeController>(
          builder: (controller) => buildMinutes(controller, buttonStyle, labelTextStyle),
        ),
      ],
    );
  }

  Wrap buildPresets(TextStyle labelTextStyle) {
    return Wrap(
      spacing: 16.0,
      children: [
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '7 x 2m',
            style: chipTextStyle,
          ),
          // onPressed: controller.started.value ? null : myTapCallback,
          onPressed: () => setOptions(7, 2),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '7 x 3m',
            style: chipTextStyle,
          ),
          onPressed: () => setOptions(7, 3),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '7 x 5m',
            style: chipTextStyle,
          ),
          onPressed: () => setOptions(7, 5),
        ),
      ],
    );
  }

  Widget buildCounter() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Countdown(
            controller: controller.countdownController,
            seconds: controller.minutes() * 60,
            build: (_, double time) {
              // print('HomePage.build $time ${controller.left()}');
              controller.tick();
              if (time % 60 == 0) controller.play();
              return Column(
                children: [
                  Text(
                    time.toInt().toString(),
                    style: counterTextStyle,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: LinearProgressIndicator(
                      value: controller.left(),
                      color: Colors.orange.withAlpha(175),
                      backgroundColor: Colors.brown,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Position ${controller.position} of ${controller.positions()} - ${controller.minutes()} minutes each",
                  ),
                ],
              );
            },
            interval: Duration(seconds: 1),
            onFinished: () {
              controller.move();

              if (!controller.finished()) {
                print('HomePage.buildCounter restarting counter');
                controller.restartCounter();
              } else {
                print('HomePage.buildCounter done!');
                controller.stop();
              }
            },
          ),
        ],
      ),
    );
  }

  Row buildMinutes(HomeController controller, ButtonStyle buttonStyle, TextStyle labelTextStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: controller.started.value ? null : controller.decrementMinutes,
            style: buttonStyle,
            child: Icon(Fontisto.minus_a),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('⌛', style: labelTextStyle),
        ),
        Expanded(
          child: Container(
            child: Obx(
              () => Text(
                "️Minutes: ${controller.minutes}",
                style: labelTextStyle,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: controller.started.value ? null : controller.incrementMinutes,
            style: buttonStyle,
            child: Icon(Fontisto.plus_a),
          ),
        ),
      ],
    );
  }

  Row buildPositions(HomeController controller, ButtonStyle buttonStyle, TextStyle labelTextStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: controller.started.value ? null : controller.decrementPosition,
            style: buttonStyle,
            child: Icon(Fontisto.minus_a),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('🙌🏻', style: labelTextStyle),
        ),
        Expanded(
          child: Container(
            child: Obx(
              () => Text(
                "Positions: ${controller.positions}",
                style: labelTextStyle,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: controller.started.value ? null : controller.incrementPosition,
            style: buttonStyle,
            child: Icon(Fontisto.plus_a),
          ),
        ),
      ],
    );
  }

  setOptions(int positions, int minutes) {
    controller.positions(positions);
    controller.minutes(minutes);
  }

  _addNewPair() => controller.started.value ? null : () => print('HomePage._addNewPair');
}

class PositionsWidget extends StatelessWidget {
  final enabled;
  final onInc;
  final onDec;
  final text;

  const PositionsWidget({Key? key, required this.enabled, this.text, this.onInc, this.onDec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => enabled ? onDec() : null,
            child: Text('-'),
            style: buttonStyle,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(text, style: labelTextStyle),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => enabled ? onInc() : null,
            style: buttonStyle,
            child: Text('+'),
          ),
        ),
      ],
    );
  }
}

final buttonStyle = ElevatedButton.styleFrom(
  shape: CircleBorder(),
  padding: EdgeInsets.all(16),
  // primary: Colors.blue.withAlpha(125),
  // primary: Colors.orangeAccent,
  primary: Colors.orangeAccent.withAlpha(200),
);

final counterTextStyle = TextStyle(
  fontSize: 100,
  color: Colors.white,
);

final chipTextStyle = TextStyle(
  fontSize: 28,
  color: Colors.white,
);

final labelTextStyle = TextStyle(
  fontSize: 32,
  color: Colors.white,
);
