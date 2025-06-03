import 'dart:convert';

import 'package:duckify/data/models/duck_audio.dart';
import 'package:flutter/services.dart';

class DuckAudioRepository {


  Future<List<DuckAudio>> getAllAudios() async {
    final String jsonString = await rootBundle.loadString('assets/json/duck_audios.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((item) => DuckAudio.fromJson(item)).toList();
  }

}