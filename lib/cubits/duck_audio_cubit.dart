import 'dart:async';

import 'package:duckify/core/duckify_audio_handler.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/data/models/duck.dart';
import 'package:duckify/data/models/duck_audio.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckAudioCubit extends Cubit<DuckAudioState> {
  final DuckAudioRepository _repository;
  final DuckIfyAudioHandler _audioHandler;
  final Map<String, List<Duck>> _cache = {};
  StreamSubscription? _playbackStateSubscription;

  DuckAudioCubit(this._repository, this._audioHandler) : super(DuckCallInitial()) {
    _playbackStateSubscription = _audioHandler.playbackState.listen((state) {
      if (this.state is DuckCallLoaded) {
        final current = this.state as DuckCallLoaded;
        if (current.isPlaying != state.playing) {
          emit(current.copyWith(isPlaying: state.playing));
        }
      }
    });
  }



  Future<void> loadSounds(String category) async {
    print('load sounds');
    if (_cache.containsKey(category)) { // Если есть в кеше - сразу отдаем
      emit(DuckCallLoaded(ducks: _cache[category]!, category: category));
      return;
    }

    emit(DuckCallLoading(category: category));

    try {
      final ducks = await _repository.getAudiosByCategory(category);
      _cache[category] = ducks; // Сохраняем в кеш
      emit(DuckCallLoaded(ducks: ducks, category: category));
    } catch (e) {
      emit(DuckCallError(message: 'Ошибка загрузки', category: category));
    }
  }

  void selectAndPlaySound(DuckAudio audio, String image) {
    if (state is! DuckCallLoaded) return;

    final currentState = state as DuckCallLoaded;
    _audioHandler.playSoundWithDelay(audio.path!, audio.name!, image);

    emit(currentState.copyWith(
      currentAudio: audio,
      isPlaying: true,
    ));
  }

  Future<void> stopSound() async {
    if (state is! DuckCallLoaded) return;

    await _audioHandler.stop();

    emit(DuckCallLoaded(
      ducks: (state as DuckCallLoaded).ducks,
      currentAudio: null,
      isPlaying: false,
      category: (state as DuckCallLoaded).category!,
    ));
    debugPrint('Stopped state: ${state.props}'); // Проверьте вывод
    debugPrint('New state: ${state.props}');
  }

  Future<void> togglePause() async {
    if (state is! DuckCallLoaded) return;

    final current = state as DuckCallLoaded;
    if (current.isPlaying) {
      await _audioHandler.pause();
    } else {
      await _audioHandler.play();
    }
  }

  @override
  Future<void> close() {
    _playbackStateSubscription?.cancel();
    return super.close();
  }
}