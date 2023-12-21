import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:scriba/services/deneme.dart';

class HikayeEkle {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<WritersStory> addHikaye(
    String hikayeAdi,
    String hikayeYazar,
    String hikayeKisaOzet,
    String hikayeTur,
  ) async {
    var ref = _firestore.collection("Writers");

    var documentRef = await ref.add({
      "kullaniciid": auth.currentUser!.uid,
      "hikayeAdi": hikayeAdi,
      "hikayeKisaOzet": hikayeKisaOzet,
      "hikayeTur": hikayeTur,
      "hikayeYazar": hikayeYazar
    });

    return WritersStory(
        id: documentRef.id,
        hikayeAdi: hikayeAdi,
        hikayeKisaOzet: hikayeKisaOzet,
        hikayeTur: hikayeTur,
        hikayeYazar: hikayeYazar);
  }

  Stream<QuerySnapshot> getWritersStatus() {
    var ref = _firestore
        .collection("Writers")
        .where("kullaniciid", isEqualTo: auth.currentUser!.uid)
        .snapshots();

    return ref;
  }
}
