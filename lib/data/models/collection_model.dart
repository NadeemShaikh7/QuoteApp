class CollectionModel {
  final String id;
  final String name;

  CollectionModel({
    required this.id,
    required this.name,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
