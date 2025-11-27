class ExpenseVoiceModel {
  final String title;
  final double amount;
  final String category;

  ExpenseVoiceModel({
    required this.title,
    required this.amount,
    required this.category,
  });

  factory ExpenseVoiceModel.fromMap(Map<String, dynamic> map) {
    return ExpenseVoiceModel(
      title: map['title'] ?? 'Unknown',
      amount: map['amount']?.toDouble() ?? 0.0,
      category: map['category'] ?? 'Others',
    );
  }
}
