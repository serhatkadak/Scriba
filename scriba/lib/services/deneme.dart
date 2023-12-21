import 'package:cloud_firestore/cloud_firestore.dart';

class WritersStory {
  String? id;
  String? hikayeAdi;
  String? hikayeBaslik;
  String? hikayeMetin;
  String? hikayeYazar;
  String? hikayeKisaOzet;
  String? hikayeTur;

  WritersStory(
      {this.hikayeAdi,
      this.hikayeBaslik,
      this.hikayeKisaOzet,
      this.hikayeMetin,
      this.hikayeYazar,
      this.hikayeTur,
      this.id});

  factory WritersStory.fromsnapshot(DocumentSnapshot snapshot) {
    return WritersStory(
      id: snapshot.id,
      hikayeAdi: snapshot["hikayeAdi"],
      hikayeBaslik: snapshot["hikayeBaslik"],
      hikayeKisaOzet: snapshot["hikayeKisaOzet"],
      hikayeMetin: snapshot["hikayeMetin"],
      hikayeYazar: snapshot["hikayeYazar"],
      hikayeTur: snapshot["hikayeTur"],
    );
  }
}
