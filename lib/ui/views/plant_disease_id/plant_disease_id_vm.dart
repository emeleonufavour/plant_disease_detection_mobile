import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import 'package:stacked/stacked.dart';

import '../../../classifier/classifier.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/tflife_constants.dart';

class PlantDiseaseIdViewModel extends BaseViewModel {
  Classifier? _classifier;

  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;

  ResultStatus _resultStatus = ResultStatus.notStarted;
  String _plantLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  File? get selectedImageFile => _selectedImageFile;
  bool get isAnalyzing => _isAnalyzing;
  String get plantLabel => _plantLabel;
  double get accuracy => _accuracy;
  ResultStatus get resultStatus => _resultStatus;

  set isAnalyzing(bool value) {
    _isAnalyzing = value;
    notifyListeners();
  }

  set resultStatus(ResultStatus value) {
    _resultStatus = value;
    notifyListeners();
  }

  set accuracy(double value) {
    _accuracy = value;
    notifyListeners();
  }

  set selectedImageFile(File? value) {
    _selectedImageFile = value;
    notifyListeners();
  }

  set plantLabel(String value) {
    _plantLabel = value;
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
    isAnalyzing = true;
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
    _plantLabel = plantLabel;
    _accuracy = accuracy;
    notifyListeners();
  }

  void onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);

    selectedImageFile = imageFile;

    analyzeImage(imageFile);
  }

  List<String> getTitleAndAccuracyLabel() {
    var title = '';

    if (_resultStatus == ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == ResultStatus.found) {
      title = _plantLabel;
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }
    return [title, accuracyLabel];
  }
}
