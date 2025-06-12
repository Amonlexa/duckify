import 'dart:convert';

import 'package:duckify/data/models/duck.dart';
import 'package:flutter/services.dart';

class DuckAudioRepository {


  Future<List<Duck>> getAudiosByCategory(String category) async {
    final String jsonString = await rootBundle.loadString('assets/duck_audios.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    // Преобразуем JSON в список DuckAudio и фильтруем по категории
    final List<Duck> allAudios = jsonList
        .map((item) => Duck.fromJson(item))
        .where((audio) => audio.categories!.contains(category))
        .toList();


    return allAudios;
  }

}