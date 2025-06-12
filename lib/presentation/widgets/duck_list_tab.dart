import 'package:duckify/cubits/duck_audio_cubit.dart';
import 'package:duckify/cubits/duck_audio_state.dart';
import 'package:duckify/presentation/screens/duck_overview_screen.dart';
import 'package:duckify/presentation/widgets/duck_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuckListTab extends StatelessWidget {
  final String category;

  const DuckListTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DuckAudioCubit, DuckAudioState>(
      bloc: context.read()!..loadSounds(category),
      builder: (context, state) {
        if(state is DuckCallLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if(state is DuckCallLoaded) {
          return ListView.builder(
            itemCount: state.ducks.length,
            itemBuilder: (context, index) {
              return DuckWidget(
                duck: state.ducks[index],
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DuckOverviewScreen(duck: state.ducks[index])));
                },
              );
            },
          );
        }
       return Center(
         child: Text('Данная категория пока пустая',style: TextStyle(fontFamily: 'Roboto',color: Colors.white,fontSize: 15),),
       );
      },
    );
  }
}