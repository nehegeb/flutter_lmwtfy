///
/// Let me WICHTEL that for you!
/// An application by nehegeb.
///
/// This file contains common functions and widgets.
/// These can be used throughout the whole app.
///

import 'package:flutter/material.dart';

///
/// LAYOUT | DISMISSIBLE LIST ENTRIES
///

// When swiping right to left.
Widget dismissibleBackgroundForDelete() {
  return Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 20.0),
    color: Colors.red,
    child: Icon(
      Icons.delete_sweep,
      color: Colors.white,
    ),
  );
}

// When swiping left to right.
Widget dismissibleBackgroundForEdit() {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 20.0),
    color: Colors.blue,
    child: Icon(
      Icons.edit,
      color: Colors.white,
    ),
  );
}
