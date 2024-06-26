import 'package:flutter/material.dart';
import 'package:plant_disease_detection/ui/style/app_dimensions.dart';
import 'package:stacked/stacked.dart';

import '../../style/app_assets.dart';
import '../../widget/pd_text.dart';
import 'splash_screen_vm.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SplashScreenViewModel(),
        onViewModelReady: (SplashScreenViewModel viewModel) async {
          viewModel.navigateToHome();
        },
        builder: (context, model, _) {
          return Scaffold(
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppAssets.plantAnimation(),
                    SizedBox(
                      height: PDimensions.height(0.1, context),
                    ),
                    const TextWidget(
                      text: 'Easily identify your plant diseases.',
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )
                  ]),
            ),
          );
        });
  }
}
