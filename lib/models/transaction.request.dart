class TransactionRequest {
  String? amount;
  String? description;
  String? type;
  String? date;
  String? category;
  String? account;
  String? currency;
  String? invoice;
  bool repeatTransaction = false;
  String? repeatFrequency;
  String? repeatInterval;
  String? invoiceFileType;
  String? invoiceFileName;
  String? repeatTransactionEndDate;

  TransactionRequest(
      {this.amount,
      this.description,
      this.type,
      this.date,
      this.category,
      this.account,
      this.currency,
      this.invoice,
      this.repeatTransaction = false,
      this.repeatFrequency,
      this.repeatInterval,
      this.invoiceFileType,
      this.invoiceFileName,
      this.repeatTransactionEndDate});

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "description": description,
      "type": type,
      "date": date,
      "category": category,
      "account": account,
      "currency": currency,
      "invoice": invoice,
      "repeatTransaction": repeatTransaction,
      "repeatFrequency": repeatFrequency,
      "repeatInterval": repeatInterval,
      "invoiceFileType": invoiceFileType,
      "invoiceFileName": invoiceFileName,
      "repeatTransactionEndDate": repeatTransactionEndDate
    };
  }
}
