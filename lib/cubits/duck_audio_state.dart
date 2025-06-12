import 'package:duckify/data/models/duck.dart';
import 'package:duckify/data/models/duck_audio.dart';

abstract class DuckAudioState {}

class DuckCallInitial extends DuckAudioState {}

class DuckCallLoading extends DuckAudioState {}

class DuckCallLoaded extends DuckAudioState {
  final List<Duck> ducks;
  final DuckAudio? currentSound;

  DuckCallLoaded({
    required this.ducks,
    this.currentSound,
  });

  DuckCallLoaded copyWith({DuckAudio? selectedSound}) {
    return DuckCallLoaded(
      ducks: ducks,
      currentSound: selectedSound ?? currentSound,
    );
  }
}

class DuckCallError extends DuckAudioState {
  final String message;
  DuckCallError({required this.message});
}