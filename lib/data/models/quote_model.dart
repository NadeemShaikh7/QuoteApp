class QuoteModel {
  final String id;
  final String text;
  final String author;
  final String category;

  QuoteModel({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'],
      text: json['text'],
      author: json['author'],
      category: json['category'],
    );
  }
}
