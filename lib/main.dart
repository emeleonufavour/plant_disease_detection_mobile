import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_disease_detection/ui/style/app_theme.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app_setup.locator.dart';
import 'app/app_setup.router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      title: 'Ella',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      //home: IntroView(),
    );
  }
}
