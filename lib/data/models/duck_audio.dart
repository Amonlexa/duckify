class DuckAudio {

  final String? id;
  final String? name;
  final String? path;
  final String? duration;

  const DuckAudio({
    this.id,
    this.name,
    this.path,
    this.duration,
  });

  factory DuckAudio.fromJson(Map<String, dynamic> map) {
    return DuckAudio(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      path: map['path'] as String? ?? '',
      duration: map['duration'] as String? ?? '',
    );
  }

}