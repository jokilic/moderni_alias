import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

Future<Directory?> getPersistenceDirectory() async {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.macOS) {
    final directory = await getLibraryDirectory();
    return directory;
  }

  return null;
}
