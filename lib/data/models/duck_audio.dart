class DuckAudio {


  String? id;
  String? title;
  String? description;
  String? audioPath;
  String? image;
  List<String>? categories;

  DuckAudio(this.id, this.title, this.description, this.audioPath, this.image, this.categories);


  DuckAudio.fromJson(Map<String,dynamic> map) {
    id = map['id'] ?? '';
    title = map['title'] ?? '';
    description = map['description'] ?? '';
    audioPath = map['audio_path'] ?? '';
    image = map['image'] ?? '';
    categories = List<String>.from(map['categories']);
  }


}