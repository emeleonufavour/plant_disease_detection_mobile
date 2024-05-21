import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import 'app_dimensions.dart';

class AppAssets {
  //Lottie
  static Widget plantAnimation([bool? animate, bool? repeat]) => Lottie.asset(
        'assets/lottie/plant.json',
        animate: animate ?? true,
        repeat: repeat ?? true,
      );

  //Svg
  static SvgPicture cameraSvg(BuildContext context) => SvgPicture.asset(
        'assets/svg/camera.svg',
        width: PDimensions.width(0.1, context),
      );
  static SvgPicture phoneSvg(BuildContext context) => SvgPicture.asset(
        'assets/svg/phone.svg',
        width: PDimensions.width(0.1, context),
      );
  static SvgPicture droneSvg(context, Color? color) =>
      SvgPicture.asset('assets/svg/drone.svg',
          color: color, width: PDimensions.width(0.1, context));
  static SvgPicture gallerySvg(context) =>
      SvgPicture.asset('assets/svg/gallery.svg',
          width: PDimensions.width(0.1, context));
}
