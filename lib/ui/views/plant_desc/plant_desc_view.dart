import 'package:flutter/material.dart';
import 'package:plant_disease_detection/ui/views/plant_desc/plant_desc_vm.dart';
import 'package:plant_disease_detection/ui/widget/pd_text.dart';
import 'package:stacked/stacked.dart';

class PlantDescView extends StatelessWidget {
  final String imagePath;
  const PlantDescView({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PlantDescViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            body: Center(
              child: TextWidget(text: "Plant!"),
            ),
          );
        });
  }
}
