import 'package:flutter/material.dart';

/// {@category Widgets}
/// {@subcategory Tools}
/// General widget for text in forms.
/// Uses a 200W x 40H pixel dimension box to store output string
/// Usage : formTextBoxWidget (<context>, <output string>),
Widget formTextBoxWidget(BuildContext context, String op) {
  return SizedBox(
    // Dimensions of text box
    width: 200.0,
    height: 40.0,
    // Column child to allign text vertically
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          op,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16.0,
          ),
        ),
      ],
    ),
  );
}

Widget textBoxWidget(String op) {
  return SizedBox(
    // Dimensions of text box
    width: 200.0,
    height: 40.0,
    // Column child to allign text vertically
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          op,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16.0,
          ),
        ),
      ],
    ),
  );
}

Widget pageLayoutTextBoxWidget(String title, double fSize) {
  return SizedBox(
    height: 40.0,
    child: Text(
      title,
      style: TextStyle(
        fontSize: fSize,
        color: Colors.grey[600],
      ),
    ),
  );
}
