import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger_service.dart';
import 'path_provider_service.dart';

final audioRecordProvider = Provider.autoDispose<AudioRecordService>(
  (ref) => AudioRecordService(
    recorderController: ref.watch(audioRecorderControllerProvider),
    logger: ref.watch(loggerProvider),
    path: ref.watch(pathProvider),
  ),
  name: 'AudioRecordProvider',
);

final audioRecorderControllerProvider = Provider.autoDispose<RecorderController>(
  (ref) {
    final controller = RecorderController();
    ref.onDispose(controller.dispose);
    return controller;
  },
  name: 'AudioRecorderControllerProvider',
);

class AudioRecordService {
  ///
  /// CONSTRUCTOR
  ///

  final RecorderController recorderController;
  final LoggerService logger;
  final PathProviderService path;

  AudioRecordService({
    required this.recorderController,
    required this.logger,
    required this.path,
  }) {
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
