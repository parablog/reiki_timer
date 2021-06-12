import 'package:flutter/material.dart';
import 'package:reiki_app/constants.dart';

class Presets extends StatelessWidget {
  final onTap;

  Presets({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Wrap(spacing: 4.0, alignment: WrapAlignment.center, children: [
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '1m x 1',
            style: kChipTextStyle,
          ),
          // onPressed: controller.started.value ? null : myTapCallback,
          onPressed: () => onTap(1, 1),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '1m x 3',
            style: kChipTextStyle,
          ),
          // onPressed: controller.started.value ? null : myTapCallback,
          onPressed: () => onTap(1, 3),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '2m x 7',
            style: kChipTextStyle,
          ),
          // onPressed: controller.started.value ? null : myTapCallback,
          onPressed: () => onTap(7, 2),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '3m x 7',
            style: kChipTextStyle,
          ),
          onPressed: () => onTap(7, 3),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '5m x 7',
            style: kChipTextStyle,
          ),
          onPressed: () => onTap(7, 5),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '2m x 12',
            style: kChipTextStyle,
          ),
          // onPressed: controller.started.value ? null : myTapCallback,
          onPressed: () => onTap(12, 2),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '3m x 12',
            style: kChipTextStyle,
          ),
          onPressed: () => onTap(12, 3),
        ),
        ActionChip(
          backgroundColor: Colors.grey,
          label: Text(
            '5m x 12',
            style: kChipTextStyle,
          ),
          onPressed: () => onTap(12, 5),
        ),
      ]),
    );
  }
}
