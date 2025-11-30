class ExpenseModel {
  String id;
  final double amount;
  final String category;
  final String note;
  final String date;
  final String wallet;
  final String uid;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
    required this.wallet,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "category": category,
      "note": note,
      "date": date,
      "wallet": wallet,
      "uid": uid,
    };
  }
}
