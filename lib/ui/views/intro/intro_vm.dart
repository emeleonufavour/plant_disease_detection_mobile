import 'package:plant_disease_detection/app/app_setup.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';

class IntroViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();

  goToHome() => _navService.navigateToHomePage();
}
