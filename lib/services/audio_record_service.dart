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

  Future<void> init() async {
    record = AudioRecorder();
    await askRecordPermission();
  }

  ///
  /// DISPOSE
  ///

  void dispose() {
    record?.dispose();
  }

  ///
  /// METHODS
  ///

  /// Asks for permission and returns value
  Future<bool> askRecordPermission() async => await record?.hasPermission() ?? false;

  /// If permission is granted, records audio
  Future<void> startRecording(String path) async {
    /// Check for audio record permission
    final hasPermission = await askRecordPermission();

    /// Start recording
    if (hasPermission) {
      /// Wrap it in `try / catch` because some devices don't have a microphone
      try {
        await record?.start(const RecordConfig(), path: path);
      } catch (e) {
        logger.e('Error in startRecording()\n$e');
      }
    }
  }

  /// Stops recording and returns `path` of the file
  Future<String?> stopRecording() async => record?.stop();
}
