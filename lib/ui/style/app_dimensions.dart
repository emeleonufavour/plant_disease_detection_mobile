import 'package:flutter/widgets.dart';

class PDimensions {
  PDimensions._();

  //responsive dimensions
  static double height(double value, BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return (height * value);
  }

  static double width(double value, BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * value);
  }
}
