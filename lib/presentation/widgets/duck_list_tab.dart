import 'package:duckify/presentation/widgets/duck_widget.dart';
import 'package:flutter/material.dart';

class SoundsListTab extends StatelessWidget {
  final String category;

  const SoundsListTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return DuckWidget(
            duck: null,
            onTap: () {

            },
            onPlayPressed: () {

            }
        );
      },
    );
  }
}