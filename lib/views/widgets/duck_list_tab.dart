import 'package:duckify/data/models/duck.dart';
import 'package:duckify/views/screens/duck_overview_screen.dart';
import 'package:flutter/material.dart';

import 'duck_widget.dart';

class DuckListTab extends StatelessWidget {



  final List<Duck> ducks;
  const DuckListTab({super.key, required this.ducks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ducks.length,
      itemBuilder: (context, index) {
        return DuckWidget(
          duck: ducks[index],
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DuckOverviewScreen(duck: ducks[index])));
          },
        );
      },
    );
  }
}