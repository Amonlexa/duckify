import 'package:duckify/data/models/duck.dart';
import 'package:duckify/data/models/duck_audio.dart';
import 'package:equatable/equatable.dart';

abstract class DuckAudioState extends Equatable {
  final String? category;

  @override
  List<Object?> get props => [category];


  const DuckAudioState({this.category});
}

class DuckCallInitial extends DuckAudioState {
  const DuckCallInitial() : super();
}

class DuckCallLoading extends DuckAudioState {
  const DuckCallLoading({required String category}) : super(category: category);
}

class DuckCallLoaded extends DuckAudioState with EquatableMixin {
  final List<Duck> ducks;
  final DuckAudio? currentAudio;
  final bool isPlaying;

  DuckCallLoaded({
    required this.ducks,
    this.currentAudio,
    this.isPlaying = false,
    required String category,
  }) : super(category: category);

  @override
  List<Object?> get props => [...super.props, ducks, currentAudio, isPlaying];


  DuckCallLoaded copyWith({
    List<Duck>? ducks,
    DuckAudio? currentAudio,
    bool? isPlaying,
  }) {
    return DuckCallLoaded(
      ducks: ducks ?? this.ducks,
      currentAudio: currentAudio ?? this.currentAudio,
      isPlaying: isPlaying ?? this.isPlaying,
      category: category!,
    );
  }


}

class DuckCallError extends DuckAudioState {
  final String message;

  DuckCallError({
    required this.message,
    required String category,
  }) : super(category: category);
}