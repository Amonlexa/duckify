import 'dart:convert';

import 'package:duckify/data/models/duck.dart';
import 'package:flutter/services.dart';

class DuckAudioRepository {
  static List<Duck>? _cachedAllDucks;

  Future<List<Duck>> _loadAllDucks() async {
    if (_cachedAllDucks != null) return _cachedAllDucks!;

    final String jsonString = await rootBundle.loadString('assets/duck_audios.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    _cachedAllDucks = jsonList.map((item) => Duck.fromJson(item)).toList();
    return _cachedAllDucks!;
  }

  Future<List<Duck>> getAudiosByCategory(String category) async {
    final allDucks = await _loadAllDucks();
    return allDucks.where((duck) => duck.categories!.contains(category)).toList();
  }

  Future<void> preloadAllData() async {
    await _loadAllDucks();
  }
}