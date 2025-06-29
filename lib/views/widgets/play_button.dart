import 'package:duckify/data/models/duck_audio.dart';
import 'package:flutter/material.dart';
class SoundListItem extends StatelessWidget {

  final DuckAudio audio;
  final VoidCallback onPlayPressed;
  final VoidCallback onFavoritePressed;
  final bool isPlaying;

  const SoundListItem({
    super.key,
    required this.onPlayPressed,
    required this.onFavoritePressed,
    required this.audio,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPlayPressed,
      leading: CircleAvatar(
        backgroundColor: Colors.amberAccent.withOpacity(0.2),
        child: Icon(
          isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
          color: isPlaying ? Colors.redAccent : Colors.amberAccent,
          size: 24,
        ),
      ),
      title: Text(
        audio.name!,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      // trailing: IconButton(
      //   icon: Icon(
      //     Icons.favorite_border,
      //     color:  Colors.amberAccent,
      //     size: 28,
      //   ),
      //   onPressed: onFavoritePressed,
      // ),
    );
  }
}