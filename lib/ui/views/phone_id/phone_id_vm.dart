import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_disease_detection/app/app_setup.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';

class PhoneIdentifyViewModel extends BaseViewModel {
  CameraDescription? camera;
  CameraController? cameraController;
  final picker = ImagePicker();
  File? _selectedImageFile;
  Future<void>? initializeControllerFuture;
  final _navigationService = locator<NavigationService>();
  bool frontCamera = true;

  Future<CameraDescription> getCamera() async {
    final cameras = await availableCameras();
    log("Cameras: $cameras");
    return cameras[1];
  }

  toggleCameraView() {
    log("tried to toggle");
    frontCamera = !frontCamera;
    log("front camera was changed to $frontCamera");
    notifyListeners();
  }

  changeCamera() {
    if (camera != null) {}
  }

  takePicture(BuildContext context) async {
    try {
      // Ensure that the camera is initialized.
      await initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await cameraController!.takePicture();

      await _navigationService.navigateToPlantDescView(imagePath: image.path);
    } catch (e) {
      // If an error occurs, log the error to the console.
      log(e.toString());
    }
  }

  switchCamera() async {
    log("trying to switch");
    try {
      final cameras = await availableCameras();
      toggleCameraView();
      camera = frontCamera ? cameras[0] : cameras[1];
      cameraController = CameraController(camera!, ResolutionPreset.max);
      await cameraController!.initialize();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void onPickPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);

    _selectedImageFile = imageFile;

    await _navigationService.navigateToPlantDescView(
        imagePath: _selectedImageFile!.path);

    // analyzeImage(imageFile);
  }
}
