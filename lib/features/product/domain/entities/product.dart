class Product {
  Product({
    required this.imageUrl,
    required this.coordinates,
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.distance
  });

  final String? imageUrl;
  static const String imageUrlKey = "imageUrl";

  final List<double> coordinates;
  static const String coordinatesKey = "coordinates";

  final String? id;
  static const String idKey = "id";

  final String? title;
  static const String titleKey = "title";

  final String? body;
  static const String bodyKey = "body";

  final String? userId;
  static const String userIdKey = "userId";

  double? distance;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      imageUrl: json["imageUrl"],
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
      id: json["id"],
      title: json["title"],
      body: json["body"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "coordinates": coordinates.map((x) => x).toList(),
    "id": id,
    "title": title,
    "body": body,
    "userId": userId,
  };

  @override
  String toString(){
    return "$imageUrl, $coordinates, $id, $title, $body, $userId, ";
  }
}
