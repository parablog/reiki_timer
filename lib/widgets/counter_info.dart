import 'package:flutter/material.dart';
import 'package:reiki_app/constants.dart';

class CounterInfo extends StatelessWidget {
  final double time;
  final double left;
  final position;
  final positions;
  final minutes;

  const CounterInfo({
    Key? key,
    required this.time,
    required this.left,
    required this.position,
    required this.positions,
    required this.minutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'seconds',
          style: kLabelTextStyle,
        ),
        Text(
          '${time.toInt()}',
          style: kCounterTextStyle,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: LinearProgressIndicator(
            value: left,
            color: Colors.orange.withAlpha(175),
            backgroundColor: Colors.brown,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          "position   $position of $positions    ($minutes minutes each)",
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
