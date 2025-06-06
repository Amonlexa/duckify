import 'dart:convert';

import 'package:duckify/data/models/duck_audio.dart';
import 'package:flutter/services.dart';

class DuckAudioRepository {


  Future<List<DuckAudio>> getAudiosByCategory(String category) async {
    final String jsonString = await rootBundle.loadString('assets/duck_audios.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    // Преобразуем JSON в список DuckAudio и фильтруем по категории
    final List<DuckAudio> allAudios = jsonList
        .map((item) => DuckAudio.fromJson(item))
        .where((audio) => audio.categories!.contains(category))
        .toList();


    return allAudios;
  }

}