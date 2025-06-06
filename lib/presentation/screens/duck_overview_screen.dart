import 'package:audio_service/audio_service.dart';
import 'package:duckify/cubits/duck_audio_cubit.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
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

class _DuckOverviewScreen extends State<DuckOverviewScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DuckAudioCubit, DuckAudioState>(
      builder: (context, state) {
        final duck = state is DuckCallLoaded ? state.currentSound : null;
        return Scaffold(
          backgroundColor: const Color(0xFF2E3B2C),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/kryakva.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.3), // затемнение
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        child: Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 40,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.7),
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        duck?.title ?? "Манок",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        duck?.description ??
                            "Здесь должно быть описание вида манка, его поведение, среда обитания и особенности крика.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Звуки ${duck?.title ?? ''}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      SoundListItem(
                        soundName: 'Кряква',
                        duration: "10",
                        isPlaying: false,
                        onPlayPressed: () {
                          context.read<DuckAudioCubit>().selectAndPlaySound();
                        },
                        onFavoritePressed: () {
                          context.read<DuckAudioCubit>().stopSound();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}