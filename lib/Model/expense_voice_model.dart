class ExpenseVoiceModel {
  final double amount;
  final String category;
  final String note;
  final String transcript;
  final bool offlineFallback;
  final String uid;   // Required for Firestore security
  final String date;  // Required for sorting

  ExpenseVoiceModel({
    required this.amount,
    required this.category,
    required this.note,
    required this.transcript,
    this.offlineFallback = false,
    required this.uid,
    required this.date,
  });

  factory ExpenseVoiceModel.fromMap(Map<String, dynamic> map) {
    return ExpenseVoiceModel(
      amount: (map["amount"] ?? 0).toDouble(),
      category: map["category"] ?? "No Detect",
      note: map["note"] ?? "",
      transcript: map["transcript"] ?? "",
      offlineFallback: map["offlineFallback"] ?? false,
      uid: map["uid"] ?? "",
      date: map["date"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "category": category,
      "note": note,
      "transcript": transcript,
      "offlineFallback": offlineFallback,
      "uid": uid,
      "date": date,
    };
  }
}