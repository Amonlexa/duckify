import 'package:duckify/presentation/screens/duck_overview_screen.dart';
import 'package:duckify/presentation/widgets/duck_widget.dart';
import 'package:flutter/material.dart';

class DuckListTab extends StatelessWidget {
  final String category;

  const DuckListTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return DuckWidget(
            duck: null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DuckOverviewScreen()),
              );
            },
            onPlayPressed: () {

            }
        );
      },
    );
  }
}