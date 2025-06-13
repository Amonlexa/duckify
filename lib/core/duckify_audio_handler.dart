import 'dart:async';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class DuckIfyAudioHandler extends BaseAudioHandler with QueueHandler,SeekHandler {
  late AudioPlayer _player;
  StreamSubscription? _playerStateSubscription;
  bool _isPlayerDisposed = false;

  DuckIfyAudioHandler() {
    _initPlayer();
  }

  void _initPlayer() {
    _player = AudioPlayer();
    _isPlayerDisposed = false;
    _setupPlayerListeners();
  }

  void _setupPlayerListeners() {
    _playerStateSubscription?.cancel();
    _playerStateSubscription = _player.playerStateStream.listen((state) {
      playbackState.add(playbackState.value.copyWith(
        playing: state.playing,
        processingState: _mapProcessingState(state.processingState),
      ));

      print("Player state updated: ${state.processingState}, playing: ${state.playing}");
    });
  }


  AudioProcessingState _mapProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle: return AudioProcessingState.idle;
      case ProcessingState.loading: return AudioProcessingState.loading;
      case ProcessingState.buffering: return AudioProcessingState.buffering;
      case ProcessingState.ready: return AudioProcessingState.ready;
      case ProcessingState.completed: return AudioProcessingState.completed;
    }
  }

  //Запускаем музыку
  Future<void> playSoundWithDelay(String assetPath, String title, String image) async {
    String asset = "assets/audios/$assetPath";
    try {
      if (_isPlayerDisposed) _initPlayer();

      await _player.stop();
      await _player.setAsset(asset);

      mediaItem.add(MediaItem(
        id: asset,
        title: title,
        artUri: await getImageFileFromAssets(image),
      ));

      await _player.play();
    } catch (e) {
      print("Playback error: $e");
    }
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    _playerStateSubscription?.cancel();
    await _player.dispose();
    _isPlayerDisposed = true;
  }


  Future<Uri> getImageFileFromAssets(String assetImage) async {
    final byteData = await rootBundle.load('assets/images/$assetImage');
    final buffer = byteData.buffer;
    Directory tempDir =  await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/file_01.png';
    return (await File(filePath).writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes))).uri;
  }

  Future<Duration?> getDuration(String assetPath) {
    return _player.setUrl(assetPath);
  }

}