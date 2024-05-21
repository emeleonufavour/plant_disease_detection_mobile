import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_disease_detection/ui/style/app_dimensions.dart';

import 'package:stacked/stacked.dart';

import '../../style/app_assets.dart';
import '../../widget/pd_text.dart';
import 'home_vm.dart';
import 'widgets/action_box.dart';
import 'widgets/intro_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, HomeViewModel model, _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: PDimensions.height(0.05, context),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextWidget(
                        text: 'What do you wish to do?😊',
                        fontWeight: FontWeight.bold,
                        fontsize: 18,
                        color: Colors.white,
                      ),
                    ),
                    ActionBox(
                      onTap: () {
                        model.snapPicture();
                        HapticFeedback.lightImpact();
                      },
                      color: Colors.blue.withOpacity(0.1),
                      text: 'Identify with phone',
                      imageAsset: AppAssets.phoneSvg(context),
                    ),
                    ActionBox(
                      //onTap: () => model.snapPicture(),
                      text: 'Talk to drone',
                      color: Colors.yellow.withOpacity(0.1),
                      imageAsset: AppAssets.droneSvg(context, Colors.yellow),
                      borderColor: Colors.yellow,
                    ),
                    ActionBox(
                      //onTap: () => model.snapPicture(),
                      text: 'Talk to Ella',
                      color: Colors.yellow.withOpacity(0.1),
                      imageAsset: AppAssets.droneSvg(context, Colors.yellow),
                      borderColor: Colors.yellow,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
