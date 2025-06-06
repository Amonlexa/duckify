import 'package:audio_service/audio_service.dart';
import 'package:duckify/core/duckify_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/duckify_audio_handler.dart';
import 'cubits/duck_audio_cubit.dart';
import 'data/repositories/duck_audio_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final audioHandler = await AudioService.init(
    builder: () => DuckIfyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'ru.amonlexasoftware.duckify.channel',
      androidNotificationChannelName: 'Duck Sounds',
      androidStopForegroundOnPause: false,
    ),
  );

  final duckAudioCubit = DuckAudioCubit(
    DuckAudioRepository(),
    audioHandler,
  );

  runApp(
    BlocProvider.value(
      value: duckAudioCubit,
      child: const MyApp(),
    ),
  );
}