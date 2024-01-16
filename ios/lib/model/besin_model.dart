class BesinModel {
  final String id;
  final String name;
  final String calorie;
  final String gram;
  final String image;
  final int category;

  BesinModel(
      this.id, this.name, this.calorie, this.gram, this.image, this.category);

  BesinModel.fromMap(this.id, Map<String, dynamic> map)
      : name = map["name"] ?? "",
        calorie = map["calorie"] ?? "",
        gram = map["gram"] ?? "",
        image = map["image"] ?? "",
        category = map["category"] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "calorie": calorie,
      "gram": gram,
      "image": image,
      "category": category,
    };
  }
}
