class Currency {
  final String name;
  final String code;

  Currency({required this.name, required this.code});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(name: json['name'], code: json['code']);
  }

  static List<Currency> listFromJson(List<dynamic> json) {
    List<Currency> currencies = [];
    for (var currency in json) {
      currencies.add(Currency.fromJson(currency));
    }
    return currencies;
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "code": code};
  }
}
