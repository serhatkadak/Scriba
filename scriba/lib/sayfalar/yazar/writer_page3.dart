import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/sayfalar/yazar/drawer.dart';
import 'package:scriba/services/hikaye_ekle_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

class WriterPage3 extends StatefulWidget {
  const WriterPage3({Key? key}) : super(key: key);

  @override
  State<WriterPage3> createState() => _WriterPage3State();
}

class _WriterPage3State extends State<WriterPage3> {
  final List<TextEditingController> _textControllers = [];
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  HikayeEkle _hikayeEkle = HikayeEkle();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController olumluHikayeMetinController = TextEditingController();
  TextEditingController olumsuzHikayeMetinController = TextEditingController();
  int _textFieldCount = 0;

  void _addTextField() {
    if (_textFieldCount < 2) {
      TextEditingController controller = TextEditingController();
      setState(() {
        _textControllers.add(controller);
        _textFieldCount++;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hikayeni Bitir"),
        backgroundColor: CustomColors.buttonTextColor,
      ),
      backgroundColor: CustomColors.girisEkranBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _customSizedBox(),
              _metinAlaniText(),
              _customSizedBox(),
              _metinAlaniText2(),
              _customSizedBox(),
              CustomTextButton(
                onPressed: () {
                  _register();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => YanMenu(),
                  ));
                },
                buttonText: "Hikayeni Yayınla",
                textColor: CustomColors.buttonBackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metinAlaniText() {
    return Material(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 2, 8, 230),
        child: TextField(
          controller: olumluHikayeMetinController,
          textInputAction: TextInputAction.done,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "İlk Seçenek İçin Hikayeni Yazmaya Devam Et",
          ),
        ),
      ),
    );
  }

  Widget _metinAlaniText2() {
    return Material(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 2, 8, 230),
        child: TextField(
          controller: olumsuzHikayeMetinController,
          textInputAction: TextInputAction.done,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "İkinci Seçenek İçin Hikayeni Yazmaya Devam Et",
          ),
        ),
      ),
    );
  }

  Widget _customSizedBox() {
    return SizedBox(height: 30);
  }

  void _register() {
    FirebaseFirestore.instance.collection("Writers").doc().set({
      "kullaniciid": auth.currentUser!.uid,
      'olumluText2': olumluHikayeMetinController.text,
      'olumsuzText2': olumsuzHikayeMetinController.text,
      'olumluSecenek2': 'Kediyi veterinere götür',
      'olumsuzSecenek2': 'Evi yarın topla',
    });

    setState(() {
      _textControllers.clear();
      _textFieldCount = 0;
    });
  }
}
