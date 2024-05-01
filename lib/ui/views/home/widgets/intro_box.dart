import 'package:flutter/material.dart';

import '../../../style/app_dimensions.dart';
import '../../../widget/pd_text.dart';

class IntroBox extends StatelessWidget {
  const IntroBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: PDimensions.height(0.2, context),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: const Column(children: [
        TextWidget(
          text: 'Hello👋',
          color: Colors.white,
          fontsize: 20,
          fontWeight: FontWeight.bold,
        ),
        TextWidget(
          text:
              // ignore: lines_longer_than_80_chars
              'This is the Mobile application of a Plant Disease Detection final year project.',
          color: Colors.white,
          textAlign: TextAlign.center,
        ),
        TextWidget(
          text:
              // ignore: lines_longer_than_80_chars
              'The Mobile application is able to identify plant diseases and read data from the Drone hardware.',
          color: Colors.white,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
