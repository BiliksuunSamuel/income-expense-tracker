import '../models/currency.dart';

class Currencies {
  static List<Currency> currencies = [
    Currency(name: "United States Dollar", code: "USD"),
    Currency(name: "Euro", code: "EUR"),
    Currency(name: "Japanese Yen", code: "JPY"),
    Currency(name: "British Pound Sterling", code: "GBP"),
    Currency(name: "Australian Dollar", code: "AUD"),
    Currency(name: "Canadian Dollar", code: "CAD"),
    Currency(name: "Swiss Franc", code: "CHF"),
    Currency(name: "Chinese Yuan", code: "CNY"),
    Currency(name: "Swedish Krona", code: "SEK"),
    Currency(name: "New Zealand Dollar", code: "NZD"),
    Currency(name: "Mexican Peso", code: "MXN"),
    Currency(name: "Singapore Dollar", code: "SGD"),
    Currency(name: "Hong Kong Dollar", code: "HKD"),
    Currency(name: "Norwegian Krone", code: "NOK"),
    Currency(name: "South Korean Won", code: "KRW"),
    Currency(name: "Turkish Lira", code: "TRY"),
    Currency(name: "Russian Ruble", code: "RUB"),
    Currency(name: "Indian Rupee", code: "INR"),
    Currency(name: "Brazilian Real", code: "BRL"),
    Currency(name: "South African Rand", code: "ZAR"),
    Currency(name: "United Arab Emirates Dirham", code: "AED"),
    Currency(name: "Argentine Peso", code: "ARS"),
    Currency(name: "Chilean Peso", code: "CLP"),
    Currency(name: "Colombian Peso", code: "COP"),
    Currency(name: "Egyptian Pound", code: "EGP"),
    Currency(name: "Indonesian Rupiah", code: "IDR"),
    Currency(name: "Israeli New Shekel", code: "ILS"),
    Currency(name: "Malaysian Ringgit", code: "MYR"),
    Currency(name: "Nigerian Naira", code: "NGN"),
    Currency(name: "Philippine Peso", code: "PHP"),
    Currency(name: "Pakistani Rupee", code: "PKR"),
    Currency(name: "Polish Zloty", code: "PLN"),
    Currency(name: "Saudi Riyal", code: "SAR"),
    Currency(name: "Thai Baht", code: "THB"),
    Currency(name: "New Taiwan Dollar", code: "TWD"),
    Currency(name: "Ukrainian Hryvnia", code: "UAH"),
    Currency(name: "Vietnamese Dong", code: "VND"),
    Currency(name: "West African CFA Franc", code: "XOF"),
    Currency(name: "Central African CFA Franc", code: "XAF"),
    Currency(name: "Kenyan Shilling", code: "KES"),
    Currency(name: "Tanzanian Shilling", code: "TZS"),
    Currency(name: "Ugandan Shilling", code: "UGX"),
    Currency(name: "Ghanaian Cedi", code: "GHS"),
    Currency(name: "Ethiopian Birr", code: "ETB"),
    Currency(name: "Algerian Dinar", code: "DZD"),
    Currency(name: "Moroccan Dirham", code: "MAD"),
    Currency(name: "Botswana Pula", code: "BWP"),
    Currency(name: "Zambian Kwacha", code: "ZMW"),
  ];

  static List<Currency> getCurrencyList() {
    //sort the currencies by name
    currencies.sort((a, b) => a.name.compareTo(b.name));
    return currencies;
  }
}
