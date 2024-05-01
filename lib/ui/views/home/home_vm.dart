import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../app/app_setup.router.dart';

class HomeViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  // FlutterTts flutterTts = FlutterTts();

  // ignore: always_declare_return_types
  snapPicture() => _navService.navigateToPlantRecogniser();
}
