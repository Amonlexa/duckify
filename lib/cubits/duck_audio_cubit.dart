import 'package:duckify/core/duckify_audio_handler.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckAudioCubit extends Cubit<DuckAudioState> {
  final DuckAudioRepository _repository;
  final DuckIfyAudioHandler _audioService;

  DuckAudioCubit(this._repository,  this._audioService) : super(DuckCallInitial());

  Future<void> loadSounds(String category) async {
    emit(DuckCallLoading());
    try {
      final sounds = await _repository.getAudiosByCategory(category); // получаем список манков без длительностей
      // final soundsWithDurations = await Future.wait(sounds.map((sound) async {
      //   final durations = await getDurationsForAudios(sound.audioPaths!);
      //   return sound.copyWith(durations: durations); // <-- вот он!
      // }));

      if (sounds.isNotEmpty) {
        emit(DuckCallLoaded(sounds: sounds));
      }
    } catch (e) {
      print(e);
      emit(DuckCallError(message: 'Не удалось загрузить звуки'));
    }
  }

  void selectAndPlaySound() async {
    String asset = 'assets/audios/kryakva-2.mp3';
    _audioService.playSoundWithDelay(asset, "Кряква");
    // emit(DuckCallLoaded(currentSound: DuckAudio( "title", "description", "assets/audios/kryakva.mp3", "image", [''], durations: []), sounds: []));
  }

  void stopSound() async{
    _audioService.stop();
    emit(DuckCallLoaded(sounds: []));
  }

  Future<List<Duration?>> getDurationsForAudios(List<String> audioPaths) async {
    final List<Duration?> durations = [];

    for (var path in audioPaths) {
      final duration = await _audioService.getDuration(path);
      durations.add(duration);
    }

    return durations;
  }


}