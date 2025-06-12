import 'package:duckify/data/models/duck_audio.dart';
import 'package:flutter/material.dart';
class SoundListItem extends StatelessWidget {

  final DuckAudio audio;
  final bool isPlaying;
  final VoidCallback onPlayPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  const SoundListItem({
    super.key,
    required this.isPlaying,
    required this.onPlayPressed,
    required this.onFavoritePressed,
    this.isFavorite = false,
    required this.audio,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.amberAccent.withOpacity(0.2),
        child: IconButton(
          icon: Icon(
            isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
            color: isPlaying ? Colors.redAccent : Colors.amberAccent,
            size: 24,
          ),
          onPressed: onPlayPressed,
        ),
      ),
      title: Text(
        audio.name!,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        audio.duration ?? 'test',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.stop : Icons.stop,
          color: isFavorite ? Colors.amberAccent : Colors.white70,
          size: 28,
        ),
        onPressed: onFavoritePressed,
      ),
    );
  }
}