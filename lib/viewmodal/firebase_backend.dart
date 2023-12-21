import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseStoreData {
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection("transaction");

  updateData(String notes, String amount) async {
    final String TransactionNotes = notes;
    final double TransactionAmount = double.parse(amount);
    DateTime TransactionDate = DateTime.now();
    final Timestamp timestamp = Timestamp.fromDate(TransactionDate);
    final QuerySnapshot qSnap = await _transaction.get();
    final int documentId = qSnap.docs.length;

    docId() {
      if (documentId <= 8) {
        String con;
        con = (documentId + 1).toString();
        con = "0${con}";
        return con;
      } else {
        if (documentId >= 9) {
          String con;
          con = (documentId + 1).toString();
          return con;
        }
      }
    }

    await _transaction.doc(docId()).set({
      'TransactionName': TransactionNotes,
      'amount': TransactionAmount,
      'dateNtime': timestamp
    });
    return true;
  }
}
