import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:stacked/stacked.dart';

import '../../../core/constants/enums.dart';
import '../../style/app_assets.dart';
import '../../style/app_dimensions.dart';
import '../../widget/pd_large_button.dart';
import '../../widget/pd_text.dart';
import 'plant_disease_id_vm.dart';
import 'plant_photo_view.dart';

class PlantRecogniser extends StatelessWidget {
  const PlantRecogniser({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PlantDiseaseIdViewModel(),
        onViewModelReady: (PlantDiseaseIdViewModel model) {
          model.loadClassifier();
        },
        builder: (context, PlantDiseaseIdViewModel model, _) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: _buildTitle(),
                    ),
                    const SizedBox(height: 20),
                    _buildPhotolView(model),
                    const SizedBox(height: 10),
                    _buildResultView(model),
                    const Spacer(flex: 5),
                    Row(
                      children: [
                        _buildPickPhotoButton(
                            title: 'Take a photo',
                            source: ImageSource.camera,
                            color: Colors.blue,
                            model: model,
                            context: context,
                            image: AppAssets.cameraSvg(context)),
                        _buildPickPhotoButton(
                            title: 'Pick from gallery',
                            source: ImageSource.gallery,
                            color: Colors.teal,
                            model: model,
                            context: context,
                            image: AppAssets.gallerySvg(context)),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildPhotolView(PlantDiseaseIdViewModel model) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        PlantPhotoView(file: model.selectedImageFile),
        _buildAnalyzingText(model),
      ],
    );
  }

  Widget _buildAnalyzingText(PlantDiseaseIdViewModel model) {
    if (!model.isBusy) {
      return const SizedBox.shrink();
    } else {
      return const Text(
        'Analyzing...',
      );
    }
  }

  Widget _buildTitle() {
    return const TextWidget(
      text: 'Plant Disease Identifier',
      textAlign: TextAlign.center,
      fontWeight: FontWeight.bold,
      fontsize: 20,
    );
  }

  Widget _buildPickPhotoButton(
      {required ImageSource source,
      required String title,
      required PlantDiseaseIdViewModel model,
      required Color color,
      required BuildContext context,
      required Widget image}) {
    return TextButton(
      onPressed: () => model.onPickPhoto(source),
      child: Container(
        width: PDimensions.width(0.4, context),
        height: PDimensions.height(0.15, context),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          image,
          SizedBox(
            height: PDimensions.height(0.01, context),
          ),
          TextWidget(
            text: title,
            fontsize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
        ])),
      ),
    );
  }

  Widget _buildResultView(PlantDiseaseIdViewModel model) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        // ignore: lines_longer_than_80_chars
        if (model.resultStatus == ResultStatus.found)
          TextWidget(
            text: 'Disease Outcome: ${model.getTitleAndAccuracyLabel()[0]}',
          ),
        const SizedBox(height: 10),
        TextWidget(text: model.getTitleAndAccuracyLabel()[1]),
      ],
    );
  }
}
