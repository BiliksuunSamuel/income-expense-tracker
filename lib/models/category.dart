class Category {
  final String id;
  final String title;

  Category({required this.id, required this.title});

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }

  //from json
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], title: json['title']);
  }

  //from json list
  static List<Category> fromJsonList(List<dynamic> jsonList) {
    List<Category> categories = [];
    jsonList.forEach((json) {
      categories.add(Category.fromJson(json));
    });
    return categories;
  }
}
