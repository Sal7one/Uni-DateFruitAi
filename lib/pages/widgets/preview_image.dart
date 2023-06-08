import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget previewImage(String imagePath) {
  return kIsWeb
      ? Image.network(imagePath, fit: BoxFit.cover)
      : Image.file(File(imagePath), fit: BoxFit.cover);
}
