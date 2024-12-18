class BudgetForDropdown {
  final String id;
  final String title;
  final String description;

  BudgetForDropdown({
    required this.id,
    required this.title,
    required this.description,
  });

  factory BudgetForDropdown.fromJson(Map<String, dynamic> json) {
    return BudgetForDropdown(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  //from list
  static List<BudgetForDropdown> listFromJson(List<dynamic> json) {
    return json.map((value) => BudgetForDropdown.fromJson(value)).toList();
  }
}
