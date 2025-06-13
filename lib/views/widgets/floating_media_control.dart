import 'package:duckify/controllers/duck_audio_cubit.dart';
import 'package:duckify/controllers/duck_audio_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingMediaControl extends StatelessWidget {
  const FloatingMediaControl({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DuckAudioCubit, DuckAudioState>(
      builder: (context, state) {
        return state is DuckCallLoaded && state.currentAudio != null ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow, size: 30, color: Colors.white),
                onPressed: () {
                  context.read<DuckAudioCubit>().togglePause();
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: Icon(Icons.square, size: 30, color: Colors.white),
                onPressed: () {
                  context.read<DuckAudioCubit>().stopSound();
                },
              ),
            ),
          ],
        ) : SizedBox();
      },
    );
  }


}