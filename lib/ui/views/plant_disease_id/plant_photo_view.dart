import 'dart:io';
import 'package:flutter/material.dart';

import '../../style/app_dimensions.dart';
import '../../widget/pd_text.dart';

class PlantPhotoView extends StatelessWidget {
  final File? file;
  const PlantPhotoView({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PDimensions.height(0.4, context),
      width: PDimensions.width(0.8, context),
      decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 3), // Offset of the shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: (file == null)
          ? _buildEmptyView()
          : Image.file(file!, fit: BoxFit.cover),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
        child: TextWidget(
      text: 'Your photo will appear here',
      color: Colors.white,
    ));
  }
}
