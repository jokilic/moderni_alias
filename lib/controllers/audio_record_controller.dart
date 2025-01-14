import 'package:audio_waveforms/audio_waveforms.dart';

import '../services/logger_service.dart';

class AudioRecordController {
  final RecorderController recorderController;
  final LoggerService logger;

  AudioRecordController({
    required this.recorderController,
    required this.logger,
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
      /// Wrap it in `try / catch` because some devices don't have a microphone
      try {
        await recorderController.record(
          path: path,
          bitRate: 128000,
          sampleRate: 44100,
        );
      } catch (e) {
        logger.e('Error in startRecording()\n$e');
      }
    }
  }

  /// Stops recording and returns `path` of the file
  Future<String?> stopRecording() async {
    try {
      return await recorderController.stop();
    } catch (e) {
      logger.e('Error in stopRecording()\n$e');
    }
    return null;
  }
}
