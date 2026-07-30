import 'package:record/record.dart';

import '../services/logger_service.dart';

class AudioRecordController {
  final LoggerService logger;
  final AudioRecorder recorder;

  AudioRecordController({
    required this.logger,
    required this.recorder,
  });

  ///
  /// METHODS
  ///

  void init() {
    askRecordPermission();
  }

  ///
  /// METHODS
  ///

  /// Checks for permission and returns value
  Future<bool> askRecordPermission() async => recorder.hasPermission();

  /// Starts recording audio
  Future<void> startRecording(String path) async {
    /// Wrap it in `try / catch` because some devices don't have a microphone
    try {
      /// Check for permission
      final hasPermission = await askRecordPermission();

      if (!hasPermission) {
        return;
      }

      /// Check if already recording
      if (await recorder.isRecording()) {
        logger.w('Skipped startRecording() because recording is already active');
        return;
      }

      /// Start recording
      await recorder.start(
        // TODO: Check possibilities here
        const RecordConfig(),
        path: path,
      );
    } catch (e) {
      logger.e('Error in startRecording()\n$e');
    }
  }

  /// Stops recording and returns `path` of the file
  Future<String?> stopRecording() async {
    /// Wrap it in `try / catch` because some devices don't have a microphone
    try {
      /// Check if already stopped recording
      if (!await recorder.isRecording()) {
        logger.w('Skipped stopRecording() because recording is not active');
        return null;
      }

      final path = await recorder.stop();

      return path;
    } catch (e) {
      logger.e('Error in stopRecording()\n$e');
    }
    return null;
  }
}
