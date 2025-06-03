import 'package:duckify/data/models/duck_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DuckOverviewScreen extends StatefulWidget {

  final DuckAudio duck;

  const DuckOverviewScreen({super.key, required this.duck});

  @override
  State<StatefulWidget> createState() => _DuckOverviewScreen();


}

class _DuckOverviewScreen extends State<DuckOverviewScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}