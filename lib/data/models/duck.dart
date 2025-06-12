import 'package:duckify/data/models/duck_audio.dart';

class Duck {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final List<String>? categories;
  final List<DuckAudio>? audios;

  const Duck({
    this.id,
    this.title,
    this.description,
    this.image,
    this.categories,
    this.audios,
  });

  factory Duck.fromJson(Map<String, dynamic> map) {
    return Duck(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      image: map['image'] as String? ?? '',
      categories: (map['categories'] as List?)?.cast<String>() ?? [],
      audios: List<DuckAudio>.from(map["audios"].map((x) => DuckAudio.fromJson(x))??{})
    );
  }

  Duck copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    List<String>? categories,
  }) {
    return Duck(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      categories: categories ?? this.categories,
    );
  }


}