import 'package:KuyMinum/model/data_harian_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DataHarianFirebase {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('data-minum');
  static DateTime date = DateTime.now();
  String tgl = DateFormat('ddMMMyyyy').format(date);

  Future<void> createData({String gambar, String ukuran, String jam}) async {
    await _collectionReference
        .doc(tgl)
        .set({'tgl': tgl, 'gambar': gambar, 'ukuran': ukuran, 'jam': jam});
  }

  // Future<List<DataHarian>> fetchData() async {
  //   try {
  //     QuerySnapshot result = await _collectionReference.get();
  //     List<DataHarian> data = result.docs.map((e) {
  //       return DataHarian.fromJson(e.data() as Map<String, dynamic>);
  //     }).toList();
  //
  //     return data;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future deleteData() async {
    try {
      // Future<void> deleteUser() {
      //   return users
      //       .doc('ABC123')
      //       .delete()
      //       .then((value) => print("User Deleted"))
      //       .catchError((error) => print("Failed to delete user: $error"));
      // }
      // await _collectionReference.doc().delete().then((value) => print("User Deleted"))
      //       .catchError((error) => print("Failed to delete user: $error"));
      await _collectionReference.snapshots().forEach((element) {
        for (QueryDocumentSnapshot snapshot in element.docs) {
          snapshot.reference.delete();
        }
      });

    } catch (e) {
      throw e;
    }
  }

  // Future<List<DataHarian>> getDataToday() async {
  //   try {
  //     QuerySnapshot result = await _collectionReference
  //         .where('tgl', isEqualTo: tgl)
  //         .orderBy('jam', descending: true)
  //         .get();
  //     List<DataHarian> data = result.docs.map((e) {
  //       return DataHarian.fromJson(e.data() as Map<String, dynamic>);
  //     }).toList();
  //
  //     return data;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
