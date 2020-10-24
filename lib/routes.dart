import 'package:cannoli_app/inputs/car_input.dart';
import 'package:cannoli_app/inputs/home_input.dart';
import 'package:flutter/material.dart';

import 'inputs/input_list.dart';

/// {@category Navigation}
/// Navigation routes
final routes = <String, WidgetBuilder>{
  // we don't need home because it is specified in main
  '/input': (context) => InputList(),
  '/input/car': (context) => CarInput(),
  '/input/electricity': (context) => HomeInput(),
};
