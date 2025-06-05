import 'package:duckify/cubits/duck_audio_cubit.dart';
import 'package:duckify/presentation/widgets/play_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckOverviewScreen extends StatefulWidget {

  // final DuckAudio duck;

  const DuckOverviewScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DuckOverviewScreen();

}

class _DuckOverviewScreen extends State<DuckOverviewScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E3B2C),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("duck.name"),
        backgroundColor: Color(0xFF2E3B2C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/kryakva.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "duck.name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amberAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "duck.category",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.amberAccent,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "duck.description" ?? "Здесь должно быть описание вида "", его поведение, среда обитания и особенности крика.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Звуки ${"duck.name"}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
           SizedBox(height: 12),
           SoundListItem(
               soundName: 'Кряква',
               duration: '09',
               isPlaying: false,
               onPlayPressed: () {
                 context.read<DuckAudioCubit>().selectSound();
                 context.read<DuckAudioCubit>().playSelectedSound();
               },
               onFavoritePressed: () {

               },
           ),
          ],
        ),
      ),
    );
  }
}