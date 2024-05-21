import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plant_disease_detection/ui/style/app_colors.dart';
import 'package:plant_disease_detection/ui/style/app_dimensions.dart';
import 'package:plant_disease_detection/ui/views/intro/intro_vm.dart';
import 'package:plant_disease_detection/ui/widget/pd_large_button.dart';
import 'package:plant_disease_detection/ui/widget/pd_text.dart';
import 'package:stacked/stacked.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => IntroViewModel(),
        builder: (context, model, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.heavyGrey,
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: PDimensions.height(0.3, context),
                        ),
                        const TextWidget(
                          text: 'Hey, There!👋',
                          color: Colors.white,
                          fontsize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        TextWidget(
                          text:
                              // ignore: lines_longer_than_80_chars
                              'This Mobile application is able to identify plant diseases and read data from the Drone hardware.',
                          color: Colors.grey.withOpacity(0.9),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    PDLargeButton(
                      label: "Get started",
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(15),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
