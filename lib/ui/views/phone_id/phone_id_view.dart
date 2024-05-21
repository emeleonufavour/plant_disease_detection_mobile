import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plant_disease_detection/ui/style/app_assets.dart';
import 'package:plant_disease_detection/ui/style/app_colors.dart';
import 'package:plant_disease_detection/ui/style/app_dimensions.dart';
import 'package:plant_disease_detection/ui/views/phone_id/phone_id_vm.dart';
import 'package:stacked/stacked.dart';
import '../../widget/pd_text.dart';

class PhoneIdentifyView extends StatefulWidget {
  const PhoneIdentifyView({super.key});

  @override
  State<PhoneIdentifyView> createState() => _PhoneIdentifyViewState();
}

class _PhoneIdentifyViewState extends State<PhoneIdentifyView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PhoneIdentifyViewModel(),
        onViewModelReady: (model) async {
          model.camera = await model.getCamera();
          log("Camera: ${model.camera}");
          model.cameraController =
              CameraController(model.camera!, ResolutionPreset.max);
          model.initializeControllerFuture =
              model.cameraController!.initialize().then((value) {
            if (!mounted) {
              return;
            }
            setState(() {});
          }).catchError((Object e) {
            if (e is CameraException) {
              log(e.toString());
            }
          });
        },
        onDispose: (model) {
          model.cameraController!.dispose();
        },
        builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(child: Builder(builder: (context) {
              return FutureBuilder(
                  future: model.initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 25.0),
                                child: TextWidget(
                                    text: "Center your plant in the circle",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontsize: 18),
                              ),
                              Expanded(
                                  child:
                                      CameraPreview(model.cameraController!)),
                            ],
                          ),
                          //facial circle
                          Align(
                              child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 10)),
                          )),
                          //capture button
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: GestureDetector(
                              onTap: () {
                                model.takePicture(context);
                              },
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      padding: const EdgeInsets.all(25),
                                      decoration: const BoxDecoration(
                                          color: AppColor.green,
                                          shape: BoxShape.circle),
                                      child: AppAssets.cameraSvg(context))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: PDimensions.height(0.07, context),
                                horizontal: PDimensions.width(0.1, context)),
                            child: GestureDetector(
                              onTap: () {
                                model.onPickPhoto();
                              },
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: AppAssets.gallerySvg(context)),
                            ),
                          )
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  });
            })),
          );
        });
  }
}
