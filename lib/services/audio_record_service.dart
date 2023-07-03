import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';

import 'logger_service.dart';
import 'path_provider_service.dart';

final audioRecordProvider = Provider.autoDispose<AudioRecordService>(
  (ref) {
    final audioRecordService = AudioRecordService(
      logger: ref.watch(loggerProvider),
      path: ref.watch(pathProvider),
    );
    ref.onDispose(audioRecordService.dispose);
    return audioRecordService;
  },
  name: 'AudioRecordProvider',
);

class AudioRecordService {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;
  final PathProviderService path;

  AudioRecordService({
    required this.logger,
    required this.path,
  }) {
    init();
  }

  ///
  /// VARIABLES
  ///

  AudioRecorder? record;

  ///
  /// INIT
  ///

  Future<bool> init() async {
    /// Initialize [AudioRecorder]
    await record?.dispose();
    record = null;
    record = AudioRecorder();

    /// Check for audio record permission
    return askRecordPermission();
  }

  ///
  /// DISPOSE
  ///

  Future<void> dispose() async {
    await record?.dispose();
  }

  ///
  /// METHODS
  ///

  /// Asks for permission and returns value
  Future<bool> askRecordPermission() async => await record?.hasPermission() ?? false;

  /// Starts recording audio
  Future<void> startRecording(String path) async {
    /// Initialize & check for permission
    final hasPermission = await init();

    /// Start recording
    if (hasPermission) {
      /// Wrap it in `try / catch` because some devices don't have a microphone
      try {
        await record?.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
          ),
          path: path,
        );
      } catch (e) {
        logger.e('Error in startRecording()\n$e');
      }
    }
  }

  /// Stops recording and returns `path` of the file
  Future<String?> stopRecording() async {
    try {
      return await record?.stop();
    } catch (e) {
      logger.e('Error in stopRecording()\n$e');
    }
    return null;
  }
}
