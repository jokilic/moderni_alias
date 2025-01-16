import 'package:flutter/material.dart';

import '../../services/background_image_service.dart';
import '../../util/dependencies.dart';
import '../../util/routing.dart';
import 'exit_game_widget.dart';

void disposeAndGoHome(BuildContext context) {
  getIt.get<BackgroundImageService>().revertBackground();
  openHome(context);
}

Future<bool> exitGameModal(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) => ExitGameWidget(),
  );

  return false;
}
