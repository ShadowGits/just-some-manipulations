import 'dart:io';

import 'package:flutter/material.dart';

class ShowCheckPickedImage extends StatelessWidget {
  final File inputImage;
  ShowCheckPickedImage(this.inputImage);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Image.file(inputImage),
    );
  }
}
