import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:reiki_app/constants.dart';

class Setter extends StatefulWidget {
  final value;
  final label;
  final Function onChange;

  Setter({
    Key? key,
    required this.label,
    required this.value,
    required this.onChange,
  }) : super();

  @override
  _SetterState createState() => _SetterState();
}

class _SetterState extends State<Setter> {
  int current = 0;

  @override
  void initState() {
    this.current = this.widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.current = this.widget.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => this.widget.onChange(decrement()),
            style: kButtonStyle,
            child: Icon(Fontisto.minus_a),
          ),
        ),
        Container(
          width: 100,
          child: Column(
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => this.widget.onChange(increment()),
            style: kButtonStyle,
            child: Icon(Fontisto.plus_a),
          ),
        ),
      ],
    );
  }

  increment() {
    if ((current + 1) == 100) return;
    setState(() {
      current++;
    });
    return current;
  }

  decrement() {
    if ((current - 1) == 0) return;
    setState(() {
      current--;
    });
    return current;
  }
}
