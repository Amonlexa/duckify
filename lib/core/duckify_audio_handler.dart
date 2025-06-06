import 'dart:async';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

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

  //Запускаем музыку
  Future<void> playSoundWithDelay(String assetPath, String title) async {
    try {
      if (_isPlayerDisposed) {
        _initPlayer();
      }

      _currentPlaybackSubscription?.cancel();

      await _player.stop();

      //инициализация уведомления музыки
      mediaItem.add(MediaItem(
        id: assetPath,
        title: title,
        album: "Тестовый",
        artUri: await getImageFileFromAssets(),
      ));

      playbackState.add(PlaybackState(
        controls: [
          MediaControl.pause,
        ],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0], // Только pause
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

  Future<Uri> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/images/kryakva.jpg');
    final buffer = byteData.buffer;
    Directory tempDir =  await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/file_01.png'; // file_01.tmp is dump file, can be anything
    return (await File(filePath).writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes))).uri;
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


  Future<Duration?> getDuration(String assetPath) {
    return _player.setUrl(assetPath);
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);



}