import 'package:duckify/core/duckify_audio_handler.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/data/models/duck_audio.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckAudioCubit extends Cubit<DuckAudioState> {
  final DuckAudioRepository _repository;
  final DuckIfyAudioHandler _audioService;

  DuckAudioCubit(this._repository,  this._audioService) : super(DuckCallInitial());

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
    _audioService.playSoundWithDelay("assets/audios/kryakva-2.mp3", "Кряква");
    emit(DuckCallLoaded(currentSound: DuckAudio("assets/audios/kryakva-2.mp3", "title", "description", "assets/audios/kryakva.mp3", "image", ['']), sounds: []));
  }

  void stopSound() async{
    _audioService.stop(); // или pauseSound(), зависит от логики
    emit(DuckCallLoaded(sounds: [])); // Обновляем состояние
  }

}