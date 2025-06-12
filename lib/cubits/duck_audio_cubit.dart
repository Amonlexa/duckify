import 'package:duckify/core/duckify_audio_handler.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/data/models/duck.dart';
import 'package:duckify/data/models/duck_audio.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckAudioCubit extends Cubit<DuckAudioState> {
  final DuckAudioRepository _repository;
  final DuckIfyAudioHandler _audioService;
  final Map<String, List<Duck>> _cache = {}; // Просто кеш в памяти

  DuckAudioCubit(this._repository, this._audioService) : super(DuckCallInitial());


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
    _audioService.playSoundWithDelay(audio.path!, audio.name!, image);

    emit(currentState.copyWith(
      currentAudio: audio,
      isPlaying: true,
    ));
  }

  Future<void> stopSound() async {
    if (state is! DuckCallLoaded) return;

    await _audioService.stop();
    final currentState = state as DuckCallLoaded;

    emit(currentState.copyWith(
      currentAudio: null,
      isPlaying: false,
    ));
  }
}