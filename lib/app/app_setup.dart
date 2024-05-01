import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/home/home.dart';
import '../ui/views/plant_disease_id/plant_disease_id.dart';
import '../ui/views/splash/splash_screen.dart';

@StackedApp(routes: [
  AdaptiveRoute(page: SplashScreen, initial: true),
  AdaptiveRoute(page: HomePage),
  AdaptiveRoute(page: PlantRecogniser),
], dependencies: [
  LazySingleton(classType: NavigationService),
])
class AppSetup {}
