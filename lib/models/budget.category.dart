class BudgetCategory {
  final String title;
  final String description;
  final String id;

  BudgetCategory(
      {required this.title, required this.description, required this.id});

  factory BudgetCategory.fromJson(Map<String, dynamic> json) {
    return BudgetCategory(
        title: json['title'], description: json['description'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'id': id};
  }

  //list
  static List<BudgetCategory> fromJsonList(List list) {
    return list.map((item) => BudgetCategory.fromJson(item)).toList();
  }
}
