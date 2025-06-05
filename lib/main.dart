import 'package:audio_service/audio_service.dart';
import 'package:duckify/core/duckify_app.dart';
import 'package:flutter/material.dart';

import 'core/duckify_audio_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioService.init(builder: () => DuckIfyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'duck_call_channel',
      androidNotificationChannelName: 'Duck Sounds',
      androidStopForegroundOnPause: true,
    ),
  );
  runApp(MyApp());
}