import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class DuckIfyAudioHandler extends BaseAudioHandler {
  late AudioPlayer _player;
  StreamSubscription? _currentPlaybackSubscription;

  bool _isPlayerDisposed = false; // <-- Ты сам будешь отслеживать состояние

  DuckIfyAudioHandler() {
    _initPlayer();
  }

  void _initPlayer() {
    _player = AudioPlayer();
    _isPlayerDisposed = false;
  }

  Future<void> playSoundWithDelay(String assetPath, String title, String category) async {
    try {
      if (_isPlayerDisposed) {
        _initPlayer();
      }

      await _player.stop();
      _currentPlaybackSubscription?.cancel();

      // Загружаем новый звук
      await _player.setAsset(assetPath);

      mediaItem.add(MediaItem(
        id: assetPath,
        title: title,
        album: category,
        artUri: Uri.parse("asset:///$assetPath"),
      ));

      _currentPlaybackSubscription = _player.playerStateStream.listen((state) async {
        if (state.processingState == ProcessingState.completed) {
          await Future.delayed(Duration(seconds: 1));
          await _player.seek(Duration.zero);
          await _player.play();
        }
      });

      await _player.play();

    } catch (e, stackTrace) {
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
  Future<void> pause() => _player.pause();

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

}