import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image/image.dart' as img;
import 'package:plant_disease_detection/service/ella_speech.dart';
import 'package:stacked/stacked.dart';

import '../../../classifier/classifier.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/tflife_constants.dart';

class PlantDescViewModel extends BaseViewModel {
  EllaService ella = EllaService();
  FlutterTts? flutterTts;
  bool _isAnalyzing = true;
  bool sayResult = true;
  double _accuracy = 0.0;
  String? _diseaseLabel;
  String? _advice;
  Classifier? _classifier;
  ResultStatus _resultStatus = ResultStatus.notStarted;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  TtsState ttsState = TtsState.stopped;

  bool get isAnalyzing => _isAnalyzing;
  String? get diseaseLabel => _diseaseLabel;
  String? get advice => _advice;

  set isAnalyzing(bool value) {
    _isAnalyzing = value;
    notifyListeners();
  }

  set setDiseaseLabel(String value) {
    _diseaseLabel = value;
    notifyListeners();
  }

  set setAdvice(String value) {
    _advice = value;
    notifyListeners();
  }

  sayResultFn(String whatToSay) async {
    int result = await flutterTts!.speak(whatToSay);
    if (result == 1) {
      sayResult = false;
      await flutterTts!.stop();
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

  Future<void> _setAwaitOptions() async {
    await flutterTts!.awaitSpeakCompletion(true);
  }

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

  Future<void> analyzeImage(File image) async {
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
      await sayResultFn("I was not able to identify the plant");
    } else if (_resultStatus == ResultStatus.found) {
      log("Label: $plantLabel, accuaracy: $accuracy");
      setAdvice = ella.sayIdentifiedDisease(plantLabel) +
          ella.proposeAdvice() +
          ella.saySolutionForRust();

      if (sayResult && _advice != null) {
        log("Advice => ${_advice}");
        await sayResultFn(_advice!);
      }
    }
    notifyListeners();
  }
}
