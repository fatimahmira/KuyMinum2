import 'package:KuyMinum/provider/base_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirestoreProvider extends BaseProvider{
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference p = FirebaseFirestore.instance.collection('data-minum');
  static DateTime date = DateTime.now();
  String tgl = DateFormat('ddMMMyyyy').format(date);
  Timestamp timestamp = Timestamp.fromDate(date);

  Future<void> createOrUpdate({String gambar, String ukuran, String jam}) async{
    var ab = {
      'tgl' : date,
      'gambar' : gambar,
      'ukuran' : ukuran,
      'jam' : jam
    };
    await p.doc().set(ab).then((value) => print(ab))
        .catchError((error) => print("Failed to add : $error"));
  }
  // Future<void> createOrUpdate({String gambar, String ukuran, String jam}) async{
  //   await p.add({
  //     'tgl' : timestamp,
  //     'gambar' : gambar,
  //     'ukuran' : ukuran,
  //     'jam' : jam
  //   }).then((value) => print("Added"))
  //       .catchError((error) => print("Failed to add : $error"));
  // }

  // Future<void> createOrUpdate(String id, {String gambar, String ukuran, String jam}) async{
  //   await p.doc("1").set({
  //     'gambar' : gambar,
  //     'ukuran' : ukuran,
  //     'jam' : jam
  //   });
  // }
  
  Future<DocumentSnapshot> getData(String id) async{
    return await p.doc(id).get();
  }

  

}