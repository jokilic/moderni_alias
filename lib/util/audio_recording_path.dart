import 'dart:io';

/// Resolves recordings stored with an old application-container path.
///
/// iOS can change the absolute application container path after an app update,
/// while keeping the Documents directory contents. The file name remains stable.
String? resolveAudioRecordingPath({
  required String? storedPath,
  required String? persistenceDirectory,
}) {
  if (storedPath == null || storedPath.isEmpty) {
    return null;
  }

  final storedFile = File(storedPath);

  if (storedFile.existsSync()) {
    return storedFile.path;
  }

  if (persistenceDirectory == null) {
    return null;
  }

  final normalizedPath = storedPath.replaceAll(r'\', '/');
  final fileName = normalizedPath.substring(normalizedPath.lastIndexOf('/') + 1);

  if (fileName.isEmpty) {
    return null;
  }

  final currentFile = File(
    '$persistenceDirectory${Platform.pathSeparator}$fileName',
  );

  return currentFile.existsSync() ? currentFile.path : null;
}
