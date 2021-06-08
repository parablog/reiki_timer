import 'package:flutter/material.dart';

final kButtonStyle = ElevatedButton.styleFrom(
  shape: CircleBorder(),
  padding: EdgeInsets.all(16),
  // primary: Colors.blue.withAlpha(125),
  // primary: Colors.orangeAccent,
  primary: Colors.orangeAccent.withAlpha(200),
);

final kCounterTextStyle = TextStyle(
  fontSize: 150,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

final kChipTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  // fontFamily: "Open Sans",
);

final kLabelTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 28,
);
