import 'package:flutter/material.dart';
import 'package:plant_disease_detection/app/app_setup.router.dart';
import 'package:plant_disease_detection/ui/style/app_dimensions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../widget/pd_text.dart';

List<Widget> introTexts = [
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
];

class IntroViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final List<Widget> animatedIntroText = [];

  goToHome() => _navService.navigateToHomePage();

  addIntroText() {
    for (final text in introTexts) {
      animatedIntroText.add(text);
      notifyListeners();
    }
  }
}
