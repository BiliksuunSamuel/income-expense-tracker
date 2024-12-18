import 'package:ie_montrac/models/transaction.dart';

class GroupedTransaction {
  final List<Transaction> today;
  final List<Transaction> yesterday;

  GroupedTransaction({required this.today, required this.yesterday});

  factory GroupedTransaction.fromJson(Map<String, dynamic> json) {
    return GroupedTransaction(
      today: json['today']
          .map<Transaction>((transaction) => Transaction.fromJson(transaction))
          .toList(),
      yesterday: json['yesterday']
          .map<Transaction>((transaction) => Transaction.fromJson(transaction))
          .toList(),
    );
  }
}
