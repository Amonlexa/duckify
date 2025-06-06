import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class DuckIfyAudioHandler extends BaseAudioHandler with QueueHandler,SeekHandler {
  late AudioPlayer _player;
  StreamSubscription? _currentPlaybackSubscription;

  bool _isPlayerDisposed = false;

  DuckIfyAudioHandler() {
    _initPlayer();
   
  }

  void _initPlayer() {
    _player = AudioPlayer();
    _isPlayerDisposed = false;
  }




  Future<void> playSoundWithDelay(String assetPath, String title) async {
    try {
      if (_isPlayerDisposed) {
        _initPlayer();
      }

      _currentPlaybackSubscription?.cancel();

      await _player.stop();

      mediaItem.add(MediaItem(
        id: assetPath,
        title: title,
        album: "Манки",
        artUri: Uri.parse('asset:///assets/images/kryakva.jpg'),
      ));

      playbackState.add(PlaybackState(
        controls: [
          MediaControl.pause,
          MediaControl.stop,
        ],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0, 1], // Только pause и stop
        processingState: AudioProcessingState.ready,
        playing: true,
        updatePosition: Duration.zero,
        bufferedPosition: Duration.zero,
        speed: 1.0,
        queueIndex: null,
      ));

      await _player.setAsset(assetPath);
      await _player.play();

      // Подписываемся на состояние
      _currentPlaybackSubscription = _player.playerStateStream.listen((state) async {
        print("Current player state: ${_player.playerState}");
        if (state.processingState == ProcessingState.completed) {
          await Future.delayed(Duration(seconds: 1));
          await _player.seek(Duration.zero);
          await _player.play();
        }
      });

    } catch (e, stackTrace) {
      print("Ошибка воспроизведения: $e");
      print(stackTrace);
    }
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await _player.dispose();
    _currentPlaybackSubscription = null;
    _isPlayerDisposed = true;
    await super.stop();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    playbackState.add(playbackState.value.copyWith(playing: false));
  }

  @override
  Future<void> play() async {
    await _player.play();
    playbackState.add(playbackState.value.copyWith(playing: true));
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);



}