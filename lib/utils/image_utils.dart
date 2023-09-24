import 'dart:io';

import 'package:path/path.dart' as p;

String getFileName(String name, File image) {
  var ext = p.extension(image.path);
  String imageName = "$name$ext";
  return imageName;
}