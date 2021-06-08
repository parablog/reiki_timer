import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:reiki_app/constants.dart';

class Setter extends StatefulWidget {
  final enabled;
  final value;
  final label;
  final Function onChange;

  Setter({
    Key? key,
    required this.label,
    required this.value,
    required this.onChange,
    this.enabled: true,
  }) : super();

  @override
  _SetterState createState() => _SetterState();
}

class _SetterState extends State<Setter> {
  int current = 0;

  @override
  void initState() {
    print('initState ${widget.label} ${this.widget.value}');
    this.current = this.widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.current = this.widget.value;
    // print('Setter.build -> ${this} - $current - ${widget.value}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // print('increment (0)');
              decrement();
              this.widget.onChange(current);
            },
            style: kButtonStyle,
            child: Icon(Fontisto.minus_a),
          ),
        ),
        Column(
          children: [
            Text(
              "${this.widget.value}",
              style: kCounterTextStyle,
            ),
            Text(
              this.widget.label,
              style: kLabelTextStyle,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: !widget.enabled
                ? null
                : () {
                    increment();
                    this.widget.onChange(current);
                  },
            style: kButtonStyle,
            child: Icon(Fontisto.plus_a),
          ),
        ),
      ],
    );
  }

  increment() {
    print('increment (1) $current');
    setState(() {
      // this.current = current + 1;
      current++;
      print('increment (2) $current');
    });
  }

  decrement() {
    print('decrement (1) $current');
    if ((current - 1) == 0) return;

    setState(() {
      // this.current = (current - 1) == 0 ? current : --current;
      current--;
    });
  }
}

// class SetterController extends GetxController {
//   var value = 3.obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   increment() => value++;
//   decrement() => (value() - 1) == 0 ? value : value--;
// }
