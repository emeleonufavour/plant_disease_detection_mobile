import 'dart:io';
import 'package:typewritertext/typewritertext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plant_disease_detection/ui/style/app_dimensions.dart';
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
        onViewModelReady: (model) async {
          model.initTts();
          await model.loadClassifier();
          await model.analyzeImage(File(imagePath));
        },
        builder: (context, model, _) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Column(children: [
                    Image.file(
                      File(imagePath),
                      width: double.maxFinite,
                      height: PDimensions.height(0.7, context),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      scale: 3,
                    ),
                    Expanded(
                        child: TypeWriterText.builder(model.advice ?? '',
                            duration: Duration(milliseconds: 50),
                            builder: (context, value) {
                      return TextWidget(
                        text: value,
                        color: Colors.white,
                        textAlign: TextAlign.left,
                      );
                    }))
                  ]),
                  Positioned(
                    top: PDimensions.height(0.07, context),
                    left: PDimensions.width(0.03, context),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.maxFinite,
                      height: PDimensions.height(0.7, context),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ])),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextWidget(
                            text: model.diseaseLabel ?? "Detecting...",
                            fontsize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
