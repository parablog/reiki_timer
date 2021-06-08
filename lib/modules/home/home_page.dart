import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reiki_app/modules/home/home_controller.dart';
import 'package:reiki_app/widgets/setter.dart';
import 'package:reiki_app/widgets/counter_info.dart';
import 'package:reiki_app/widgets/presets.dart';
import 'package:timer_count_down/timer_count_down.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class HomePage extends GetView<HomeController> {
  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: <Widget>[
            BackgroundImage(),
            GradientOverlay(),
            Logo(),
            buildPauseButton(),
            buildBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Obx(
          () =>
              controller.started() ? Icon(Icons.stop) : Icon(Icons.play_arrow),
        ),
        onPressed: controller.startStop,
        elevation: 0.0,
      ),
    );
  }

  Widget buildBody() {
    return GetX<HomeController>(
      builder: (controller) => AnimatedCrossFade(
        firstChild: buildConfig(),
        secondChild: buildCounter(),
        crossFadeState: controller.started()
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  Column buildConfig() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GetX<HomeController>(
              builder: (controller) {
                return Setter(
                  label: 'minutes',
                  value: controller.minutes(),
                  onChange: (value) => controller.minutes(value),
                );
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            GetX<HomeController>(builder: (controller) {
              return Setter(
                label: 'positions',
                value: controller.positions(),
                onChange: (value) => controller.positions(value),
              );
            }),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Divider(
          color: Colors.orange.withAlpha(175),
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
          child: Container(
            child: Presets(
              onTap: (int positions, int minutes) =>
                  setOptions(positions, minutes),
            ),
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }

  Widget buildCounter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 300,
          child: Countdown(
            controller: controller.countdownController,
            seconds: controller.seconds,
            build: (_, double time) {
              controller.tick();

              return CounterInfo(
                time: time,
                left: controller.left(),
                position: controller.position + 1,
                positions: controller.positions(),
                minutes: controller.minutes(),
              );
            },
            interval: Duration(seconds: 1),
            onFinished: () {
              controller.play();
              controller.move();
              if (controller.finished()) {
                Future.delayed(Duration(seconds: 1), () {
                  controller.play();
                  controller.stop();
                });
              } else {
                controller.restartCounter();
              }
            },
          ),
        ),
      ],
    );
  }

  setOptions(int positions, int minutes) {
    controller.positions(positions);
    controller.minutes(minutes);
  }

  GetX<HomeController> buildPauseButton() {
    return GetX<HomeController>(
      builder: (controller) => controller.started()
          ? Positioned(
              bottom: 16.0,
              left: 16.0,
              child: ElevatedButton(
                child: Icon(
                  controller.paused() ? Icons.play_arrow : Icons.pause,
                ),
                onPressed: () => controller.pause(),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  elevation: 0.0,
                  primary: Colors.orangeAccent.withAlpha(200),
                ),
              ),
            )
          : Container(),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 25,
      height: 63,
      top: 8.0,
      left: 8.0,
      child: Container(
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(
              'assets/images/reiki-white.png',
            ),
          ),
        ),
      ),
    );
  }
}

class GradientOverlay extends StatelessWidget {
  const GradientOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
