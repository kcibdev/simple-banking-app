class UserModel {
  UserModel({
    this.phoneNumber,
    this.balance,
  });

  String? phoneNumber;
  int? balance;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phoneNumber: json["phoneNumber"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "balance": balance,
      };
}
