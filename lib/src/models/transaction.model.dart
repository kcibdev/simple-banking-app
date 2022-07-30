class TransactionModel {
  TransactionModel({
    this.type,
    this.amount,
    this.phoneNumber,
    this.created,
  });

  String? type;
  int? amount;
  String? phoneNumber;
  DateTime? created;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        type: json["type"],
        amount: json["amount"],
        phoneNumber: json["phoneNumber"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
        "phoneNumber": phoneNumber,
        "created": created!.toIso8601String(),
      };
}
