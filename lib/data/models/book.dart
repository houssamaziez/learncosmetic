class Book {
  final int id;
  final String title;
  final String description;
  final String pdfUrl;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.pdfUrl,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      pdfUrl: json['pdf_url'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'pdf_url': pdfUrl,
      'image_url': imageUrl,
    };
  }
}
