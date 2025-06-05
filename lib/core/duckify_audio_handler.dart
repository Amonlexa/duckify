import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class DuckifyAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playSound(String assetPath, {String? title}) async {
    await _player.setAsset(assetPath);
    await _player.play();

    // Обновляем медиа-информацию в уведомлении
    mediaItem.add(MediaItem(
      id: assetPath,
      title: title ?? "Звук утки",
      album: "Манок Уток",
      artUri: Uri.parse("asset:///$assetPath"),
    ));
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  Stream<PlaybackState> get playbackStateStream => _player.playerStateStream.map(
        (state) => playbackState.value.copyWith(
      playing: state.playing,
      controls: [
        if (state.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
      ],
      systemActions: {MediaAction.seek},
      androidCompactActionIndices: [0, 1],
    ),
  );
}