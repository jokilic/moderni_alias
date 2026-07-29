import 'package:audio_waveforms/audio_waveforms.dart';

import '../services/logger_service.dart';

class AudioRecordController {
  final LoggerService logger;
  final RecorderController recorderController;

  AudioRecordController({
    required this.logger,
    required this.recorderController,
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

  /// Asks for permission and returns value
  Future<bool> askRecordPermission() async => recorderController.checkPermission();

  /// Starts recording audio
  Future<void> startRecording(String path) async {
    /// Check for permission
    final hasPermission = await askRecordPermission();

    /// Start recording
    if (hasPermission) {
      if (recorderController.isRecording) {
        logger.w('Skipped startRecording() because recording is already active');
        return;
      }

      /// Wrap it in `try / catch` because some devices don't have a microphone
      try {
        await recorderController.record(path: path);
      } catch (e) {
        logger.e('Error in startRecording()\n$e');
      }
    }
  }

  /// Stops recording and returns `path` of the file
  Future<String?> stopRecording() async {
    if (!recorderController.isRecording) {
      logger.w('Skipped stopRecording() because recording is not active');
      return null;
    }

    try {
      return await recorderController.stop();
    } catch (e) {
      logger.e('Error in stopRecording()\n$e');
    }
    return null;
  }
}
