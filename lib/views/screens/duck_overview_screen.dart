import 'package:duckify/controllers/constans.dart';
import 'package:duckify/controllers/duck_audio_cubit.dart';
import 'package:duckify/controllers/duck_audio_state.dart';
import 'package:duckify/data/models/duck.dart';
import 'package:duckify/views/widgets/floating_media_control.dart';
import 'package:duckify/views/widgets/play_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckOverviewScreen extends StatefulWidget {

  final Duck duck;

  const DuckOverviewScreen({super.key, required this.duck});

  @override
  State<StatefulWidget> createState() => _DuckOverviewScreen();

}

class _DuckOverviewScreen extends State<DuckOverviewScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DuckAudioCubit, DuckAudioState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Constants.backgroundColor,
          floatingActionButton: FloatingMediaControl(),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/${widget.duck.image}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.3), // затемнение
                      ),
                    ),
                    // Positioned(
                    //   right: 16,
                    //   top: 40,
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.white.withOpacity(0.7),
                    //     child: Icon(
                    //       Icons.favorite_outline,
                    //       color: Colors.red,
                    //     ),
                    //   ),
                    // ),
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
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Center(
                        child: Text(
                          widget.duck.title.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '${widget.duck.title} куоластара',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ListView.builder(
                        itemCount: widget.duck.audios!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final currentAudio = widget.duck.audios![index];
                          return SoundListItem(
                            audio: currentAudio,
                            isPlaying: state is DuckCallLoaded && state.isPlaying && currentAudio.id == state.currentAudio!.id,
                            onPlayPressed: () async {
                              if(state is DuckCallLoaded && state.isPlaying && currentAudio.id == state.currentAudio!.id){
                              context.read<DuckAudioCubit>().stopSound();
                              }else{
                                context.read<DuckAudioCubit>().selectAndPlaySound(widget.duck.audios![index], widget.duck.image!);
                              }
                            },
                            onFavoritePressed: () {
                             //Добавить в избранное
                            },
                          );
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