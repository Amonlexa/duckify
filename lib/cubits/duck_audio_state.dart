import 'package:duckify/data/models/duck_audio.dart';

abstract class DuckAudioState {}

class DuckCallInitial extends DuckAudioState {}

class DuckCallLoading extends DuckAudioState {}

class DuckCallLoaded extends DuckAudioState {
  final List<DuckAudio> sounds;
  final DuckAudio? currentSound;

  DuckCallLoaded({
    required this.sounds,
    this.currentSound,
  });

  DuckCallLoaded copyWith({DuckAudio? selectedSound}) {
    return DuckCallLoaded(
      sounds: sounds,
      currentSound: selectedSound ?? currentSound,
    );
  }
}

class DuckCallError extends DuckAudioState {
  final String message;
  DuckCallError({required this.message});
}