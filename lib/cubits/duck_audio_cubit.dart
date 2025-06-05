import 'package:audio_service/audio_service.dart';
import 'package:duckify/core/duckify_audio_handler.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/data/models/duck_audio.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckAudioCubit extends Cubit<DuckAudioState> {
  final DuckAudioRepository _repository;
  final DuckifyAudioHandler _audioHandler;

  DuckAudioCubit(this._repository, this._audioHandler) : super(DuckCallInitial());

  Future<void> loadSounds() async {
    emit(DuckCallLoading());
    try {
      final sounds = await _repository.getAllAudios();
      emit(DuckCallLoaded(sounds: sounds));
    } catch (e) {
      emit(DuckCallError(message: 'Не удалось загрузить звуки'));
    }
  }

  void selectSound() {
    print('play1');
    emit(DuckCallLoaded(sounds: [],currentSound: DuckAudio("id", "title", "description", "assets/audios/kryakva.mp3", "image", [''])));
  }

  void playSelectedSound() {
    print('play2');
    final selected = (state as DuckCallLoaded).currentSound;
    if (selected != null) {
      _audioHandler.mediaItem.add(MediaItem(
        id: "selected.assetPath",
        title: "selected.name",
        album: "selected.category",
      ));
      _audioHandler.playSound("assets/audios/kryakva.mp3");
    }
  }
}