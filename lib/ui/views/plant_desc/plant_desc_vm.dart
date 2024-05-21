import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:stacked/stacked.dart';

import '../../../classifier/classifier.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/tflife_constants.dart';

class PlantDescViewModel extends BaseViewModel {
  bool _isAnalyzing = true;
  double _accuracy = 0.0;
  String? _diseaseLabel;
  Classifier? _classifier;
  ResultStatus _resultStatus = ResultStatus.notStarted;

  bool get isAnalyzing => _isAnalyzing;
  String? get diseaseLabel => _diseaseLabel;

  set isAnalyzing(bool value) {
    _isAnalyzing = value;
    notifyListeners();
  }

  set setDiseaseLabel(String value) {
    _diseaseLabel = value;
    notifyListeners();
  }

  Future<void> loadClassifier() async {
    log(
      'Start loading of Classifier with '
      'labels at ${TFLiteConstant.labelsFileName}, '
      'model at ${TFLiteConstant.modelFileName}',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: TFLiteConstant.labelsFileName,
      modelFileName: TFLiteConstant.modelFileName,
    );

    _classifier = classifier!;
  }

  void analyzeImage(File image) {
    setBusy(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier!.predict(imageInput);

    final result = resultCategory.score >= 0.8
        ? ResultStatus.found
        : ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    isAnalyzing = false;
    setBusy(false);

    _resultStatus = result;
    setDiseaseLabel = plantLabel;
    _accuracy = accuracy;

    if (_resultStatus == ResultStatus.notFound) {
    } else if (_resultStatus == ResultStatus.found) {
      log("Label: $plantLabel, accuaracy: $accuracy");
    }
    notifyListeners();
  }
}
