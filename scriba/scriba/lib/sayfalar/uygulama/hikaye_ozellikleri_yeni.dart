import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HikayeOzellikleri_ extends StatefulWidget {
  String? imgUrl;
  String? name;
  String? auther;
  num? score;
  num? review;
  num? view;
  List<String>? type;
  String? desc;

  HikayeOzellikleri_(this.imgUrl, this.name, this.auther, this.score,
      this.review, this.view, this.type, this.desc,
      {super.key});

  @override
  State<HikayeOzellikleri_> createState() => _HikayeOzellikleri_State();
}

class _HikayeOzellikleri_State extends State<HikayeOzellikleri_> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference kitapRef = _firestore.collection('Writers');
    return StreamBuilder<QuerySnapshot>(
      /// Neyi dinlediğimiz bilgisi, hangi streami
      stream: kitapRef.snapshots(),

      /// Streamden her yerni veri aktığında, aşağıdaki metodu çalıştır
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(child: Text('Bir Hata Oluştu, Tekrar Deneynizi'));
        } else {
          if (asyncSnapshot.hasData) {
            List<DocumentSnapshot> listOfDocumentSnap = asyncSnapshot.data.docs;
            return Flexible(
              child: ListView.builder(
                itemCount: listOfDocumentSnap.length,
                itemBuilder: (context, index) {},
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }

  static List<HikayeOzellikleri_> sizinIcinOnerilenler() {
    return [
      HikayeOzellikleri_(
        'assets/images/buyuk-akil.jpg',
        'Büyük Akıl',
        'Serhat Kadak',
        4.0,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri_(
        'assets/images/sırali-sırasiz.jpg',
        'Sıralı Sırasız',
        'Serhat Kadak',
        4.7,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri_(
        'assets/images/kole-olmayacagiz.jpg',
        'Köle Olmayacağız',
        'Serhat Kadak',
        4.3,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri_(
        'assets/images/sandition.jpg',
        'Sandition',
        'Serhat Kadak',
        3.5,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      )
    ];
  }

  static List<HikayeOzellikleri_> populerOlanlar() {
    return [
      HikayeOzellikleri_(
        'assets/images/buyuk-akil.jpg',
        'Büyük Akıl',
        'Serhat Kadak',
        4.0,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri_(
        'assets/images/sırali-sırasiz.jpg',
        'Sıralı Sırasız',
        'Serhat Kadak',
        4.7,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri_(
        'assets/images/kole-olmayacagiz.jpg',
        'Köle Olmayacağız',
        'Serhat Kadak',
        4.3,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri_(
        'assets/images/sandition.jpg',
        'Sandition',
        'Serhat Kadak',
        3.5,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      )
    ];
  }
}
