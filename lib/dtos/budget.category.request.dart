class BudgetCategoryRequest {
  final String title;
  final String description;

  BudgetCategoryRequest({required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }
}
