import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../app/app_setup.router.dart';

class SplashScreenViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  void navigateToHome() async {
    Future.delayed(const Duration(seconds: 4), () {
      // Navigate to the IntroView
      _navService.navigateToIntroView();
    });
  }
}
