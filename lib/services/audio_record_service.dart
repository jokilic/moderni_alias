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
  });

  ///
  /// VARIABLES
  ///

  late final record = AudioRecorder();

  ///
  /// DISPOSE
  ///

  void dispose() {
    record.dispose();
  }

  ///
  /// METHODS
  ///

  /// If permission is granted, records audio
  Future<void> startRecording(String path) async {
    /// Check for audio record permission
    final hasPermission = await record.hasPermission();

    /// Start recording
    if (hasPermission) {
      await record.start(const RecordConfig(), path: path);
    }
  }

  /// Stops recording and returns `path` of the file
  Future<String?> stopRecording() async => record.stop();
}
