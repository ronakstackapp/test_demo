import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('User');

class Database {
  static String? userUid;

  static Future<void>  addItem({ required Map<String,dynamic> data}) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(data['email']);


    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }


//   static Stream<QuerySnapshot> readItems() {
//     CollectionReference notesItemCollection =
//     _mainCollection.doc().collection('User');
// print(("readItems --->>${ notesItemCollection.snapshots().length}"));
//     return notesItemCollection.snapshots();
//   }


  static Future<void> updateItem({Map<String,dynamic>? data,String? docId}) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(docId);
    await documentReferencer
        .update(data!)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }


  // Deleteing a product by id
static  Future<void> deleteProduct(String productId) async {
    await _mainCollection.doc(productId).delete();

    // Show a snackbar
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('You have successfully deleted a product')));
  }
}