import 'package:duckify/data/models/duck_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DuckWidget extends StatelessWidget {
  DuckAudio? duck;
  final VoidCallback onTap;        // Открытие детальной информации
  final VoidCallback onPlayPressed; // Воспроизведение звука

  DuckWidget({
    super.key,
    this.duck,
    required this.onTap,
    required this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF3A4B3C).withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/kryakva.jpg",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Название утки",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Категория",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(width: 8),
            // IconButton(
            //   icon: Icon(
            //     Icons.play_circle_outline,
            //     color: Colors.white,
            //     size: 36,
            //   ),
            //   onPressed: onPlayPressed,
            // ),
          ],
        ),
      ),
    );
  }

}