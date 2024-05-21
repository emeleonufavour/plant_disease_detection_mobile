import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plant_disease_detection/ui/style/app_colors.dart';
import 'package:plant_disease_detection/ui/style/app_dimensions.dart';
import 'package:plant_disease_detection/ui/views/intro/intro_vm.dart';
import 'package:plant_disease_detection/ui/widget/pd_large_button.dart';
import 'package:stacked/stacked.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => IntroViewModel(),
        onViewModelReady: (model) => model.addIntroText(),
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
                      children: [
                        SizedBox(
                          height: PDimensions.height(0.3, context),
                        ),
                        ...model.animatedIntroText.map((Widget e) => (e)
                            .animate()
                            .slideY(
                                begin: 5,
                                duration: Duration(
                                  milliseconds: 800 *
                                      (model.animatedIntroText.indexOf(e) + 1),
                                ),
                                curve: Curves.easeOut)
                            .fadeIn(
                                begin: 0.1,
                                delay: Duration(
                                    milliseconds: 300 *
                                        (model.animatedIntroText.indexOf(e) +
                                            1))))
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
