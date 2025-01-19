class News {
  final String title;
  final String url;
  String? imageUrl; // Campo opzionale per l'immagine
  String? smallImageUrl; // Campo opzionale per l'immagine piccola
  String? description; // Campo opzionale per la descrizione
  DateTime? date; // Campo opzionale per la data

  News({
    required this.title,
    required this.url,
    this.imageUrl,
    this.smallImageUrl,
    this.description,
    this.date,
  });

  @override
  String toString() {
    return 'News(title: $title, url: $url, imageUrl: $imageUrl, smallImageUrl: $smallImageUrl, description: $description, date: $date)';
  }
}
