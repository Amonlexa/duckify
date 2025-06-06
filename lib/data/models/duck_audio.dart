class DuckAudio {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? audioPaths;
  final String? image;
  final List<String>? categories;
  final List<Duration?> durations;

  const DuckAudio({
    this.id,
    this.title,
    this.description,
    this.audioPaths,
    this.image,
    this.categories,
    required this.durations,
  });

  factory DuckAudio.fromJson(Map<String, dynamic> map) {
    return DuckAudio(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      audioPaths: (map['audio_paths'] as List?)?.cast<String>() ?? [],
      image: map['image'] as String? ?? '',
      categories: (map['categories'] as List?)?.cast<String>() ?? [],
      durations: [], // по умолчанию пустой список
    );
  }

  DuckAudio copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? audioPaths,
    String? image,
    List<String>? categories,
    List<Duration?>? durations,
  }) {
    return DuckAudio(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      audioPaths: audioPaths ?? this.audioPaths,
      image: image ?? this.image,
      categories: categories ?? this.categories,
      durations: durations ?? this.durations,
    );
  }


}