import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reiki_app/modules/home/home_page.dart';
import 'package:reiki_app/services/sound_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  print('starting services:  ${DateTime.now().toIso8601String()}');
  await Get.putAsync(() => SoundService().init());
  print('All services started.');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reiki Timer',
      initialRoute: '/home',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        accentColor: Colors.deepOrangeAccent,

        // Define the default font family.
        fontFamily: 'WireOne',
      ),
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: HomeBindings(),
        ),
      ],
    );
  }
}
