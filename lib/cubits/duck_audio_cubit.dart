import 'package:audio_service/audio_service.dart';
import 'package:duckify/core/duckify_audio_handler.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/data/models/duck_audio.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckAudioCubit extends Cubit<DuckAudioState> {
  final DuckAudioRepository _repository;
  final DuckIfyAudioHandler _audioHandler;

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


  void selectAndPlaySound() {
    print('play2');
    _audioHandler.playSoundWithDelay("assets/audios/kryakva.mp3", "Звук", '');
    emit(DuckCallLoaded(currentSound: DuckAudio("id", "title", "description", "assets/audios/kryakva.mp3", "image", ['']), sounds: []));
  }

  void stopSound() async{
    _audioHandler.stop(); // или pauseSound(), зависит от логики
    emit(DuckCallLoaded(sounds: [])); // Обновляем состояние
  }

}