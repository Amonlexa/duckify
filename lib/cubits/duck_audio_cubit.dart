import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/data/models/duck_audio.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckAudioCubit extends Cubit<DuckAudioState> {
  final DuckAudioRepository _repository;

  DuckAudioCubit(this._repository) : super(DuckCallInitial());

  Future<void> loadSounds() async {
    emit(DuckCallLoading());
    try {
      final sounds = await _repository.getAllAudios();
      emit(DuckCallLoaded(sounds: sounds));
    } catch (e) {
      emit(DuckCallError(message: 'Не удалось загрузить звуки'));
    }
  }

  void playSound(DuckAudio sound) {
    // final handler = AudioServiceBackground.handler;
    // handler?.playSound(sound.assetPath);
    // emit((state as DuckCallLoaded).copyWith(selectedSound: sound));
  }
}