import 'package:flutter/material.dart';
class SoundListItem extends StatelessWidget {
  final String soundName;
  final String duration;
  final bool isPlaying;
  final VoidCallback onPlayPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  const SoundListItem({
    super.key,
    required this.soundName,
    required this.duration,
    required this.isPlaying,
    required this.onPlayPressed,
    required this.onFavoritePressed,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        soundName,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        duration,
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