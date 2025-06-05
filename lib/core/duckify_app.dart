import 'package:audio_service/audio_service.dart';
import 'package:duckify/cubits/duck_audio_cubit.dart';
import 'package:duckify/data/repositories/duck_audio_repository.dart';
import 'package:duckify/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'duckify_audio_handler.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DuckAudioCubit(DuckAudioRepository(),DuckIfyAudioHandler()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.amberAccent
            )
          )
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }

}


