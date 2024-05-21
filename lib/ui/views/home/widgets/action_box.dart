import 'package:flutter/material.dart';

import '../../../style/app_assets.dart';
import '../../../style/app_dimensions.dart';
import '../../../widget/pd_text.dart';

class ActionBox extends StatelessWidget {
  final void Function()? onTap;
  final Widget imageAsset;
  final String text;
  final Color? color;
  final Color? borderColor;
  const ActionBox(
      {this.onTap,
      required this.imageAsset,
      required this.text,
      this.borderColor,
      this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: PDimensions.height(0.07, context),
          decoration: BoxDecoration(
              color: color ?? Colors.lightBlue,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: borderColor ?? Colors.blue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: imageAsset),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextWidget(
                  text: text,
                  fontsize: 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
