import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import 'package:stacked/stacked.dart';

import '../../../classifier/classifier.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/tflife_constants.dart';

class PlantDiseaseIdViewModel extends BaseViewModel {
  FlutterTts? flutterTts;
  Classifier? _classifier;

  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;
  bool sayResult = true;

  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  ResultStatus _resultStatus = ResultStatus.notStarted;
  String _plantLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  File? get selectedImageFile => _selectedImageFile;
  bool get isAnalyzing => _isAnalyzing;
  String get plantLabel => _plantLabel;
  double get accuracy => _accuracy;
  ResultStatus get resultStatus => _resultStatus;

  updateSayResult(bool value) {
    sayResult = value;
    notifyListeners();
  }

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

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts!.setStartHandler(() {
      log("Playing");
      ttsState = TtsState.playing;
      notifyListeners();
    });

    flutterTts!.setCompletionHandler(() {
      log("Complete");
      ttsState = TtsState.stopped;
      notifyListeners();
    });

    flutterTts!.setCancelHandler(() {
      log("Cancel");
      ttsState = TtsState.stopped;
      notifyListeners();
    });

    flutterTts!.setPauseHandler(() {
      log("Paused");
      ttsState = TtsState.paused;
      notifyListeners();
    });

    flutterTts!.setContinueHandler(() {
      log("Continued");
      ttsState = TtsState.continued;
      notifyListeners();
    });

    flutterTts!.setErrorHandler((msg) {
      log("error: $msg");
      ttsState = TtsState.stopped;
      notifyListeners();
    });
  }

  Future<dynamic> _getLanguages() async => await flutterTts!.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts!.getEngines;

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts!.getDefaultEngine;
    if (engine != null) {
      log(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts!.getDefaultVoice;
    if (voice != null) {
      log(voice);
    }
  }

  Future<void> _speak() async {
    await flutterTts!.setVolume(volume);
    await flutterTts!.setSpeechRate(rate);
    await flutterTts!.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts!.speak(_newVoiceText!);
      }
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts!.awaitSpeakCompletion(true);
  }

  Future<void> _stop() async {
    var result = await flutterTts!.stop();
    if (result == 1) {
      ttsState = TtsState.stopped;
      notifyListeners();
    }
  }

  Future<void> _pause() async {
    var result = await flutterTts!.pause();
    if (result == 1) {
      ttsState = TtsState.paused;
      notifyListeners();
    }
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

    if (_resultStatus == ResultStatus.notFound) {
      sayResultFn("I was not able to identify the plant");
    } else if (_resultStatus == ResultStatus.found) {
      if (sayResult) {
        sayResultFn("""
         The identified disease is $plantLabel. It was identified with an accuracy of ${(_accuracy * 100).toStringAsFixed(2)}%
""");
      }
    }
    notifyListeners();
  }

  void onPickPhoto(ImageSource source) async {
    updateSayResult(true);
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);

    selectedImageFile = imageFile;

    analyzeImage(imageFile);
  }

  Future<List<String>> getTitleAndAccuracyLabel() async {
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

  sayResultFn(String whatToSay) async {
    int result = await flutterTts!.speak(whatToSay);
    if (result == 1) {
      sayResult = false;
      await flutterTts!.stop();
      notifyListeners();
    }
  }
}
