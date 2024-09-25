class Show {
  final int id;
  final String name;
  final String? image;
  final String summary;
  final List<String> genres;
  final String language;
  final String premiered;

  Show({
    required this.id,
    required this.name,
    this.image,
    required this.summary,
    required this.genres,
    required this.language,
    required this.premiered,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      name: json['name'],
      image: json['image'] != null ? json['image']['medium'] : null,
      summary: json['summary'] ?? 'No summary available.',
      genres: List<String>.from(json['genres']),
      language: json['language'] ?? 'Unknown',
      premiered: json['premiered'] ?? 'Unknown',
    );
  }
}
