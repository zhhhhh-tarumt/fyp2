import 'package:cloud_firestore/cloud_firestore.dart';

class TransferContactController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Normalize the phone input
  /// UI input: 1110284657
  /// Output:   01110284657
  String normalizePhone(String input) {
    String cleaned = input.replaceAll(" ", "").replaceAll("-", "");

    // remove +60 if user typed
    if (cleaned.startsWith("+60")) {
      cleaned = cleaned.substring(3);
    }

    // add leading 0 if missing
    if (!cleaned.startsWith("0")) {
      cleaned = "0$cleaned";
    }

    return cleaned;
  }

  /// Load all users from Firestore
  Future<List<Map<String, dynamic>>> loadContacts() async {
    final snapshot = await _firestore.collection("users").get();

    return snapshot.docs.map((doc) {
      final phone = doc["phoneNumber"];
      String withoutZero = phone.substring(1); // skip leading zero
      return {
        "uid": doc.id,
        "name": doc["username"],
        "phoneNumber": phone,
        "displayPhone": "+60 ${withoutZero.substring(0, 2)} ${withoutZero.substring(2)}",
      };
    }).toList();
  }

  /// Search for exact phone in Firestore
  Future<Map<String, dynamic>?> findContactByInput(String input) async {
    final phone = normalizePhone(input);

    final query = await _firestore
        .collection("users")
        .where("phoneNumber", isEqualTo: phone)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return {
      "uid": doc.id,
      "name": doc["username"],
      "phoneNumber": phone,
    };
  }
}
