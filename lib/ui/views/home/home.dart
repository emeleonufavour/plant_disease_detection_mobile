import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                    //Into box
                    const IntroBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextWidget(
                        text: 'What do you wish to do?😊',
                        fontWeight: FontWeight.bold,
                        fontsize: 18,
                      ),
                    ),
                    ActionBox(
                      onTap: () {
                        model.snapPicture();
                        HapticFeedback.lightImpact();
                      },
                      text: 'Identify with phone',
                      imageAsset: AppAssets.phoneSvg(context),
                    ),
                    ActionBox(
                      //onTap: () => model.snapPicture(),
                      text: 'Talk to drone',
                      imageAsset: AppAssets.droneSvg(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
