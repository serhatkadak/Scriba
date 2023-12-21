import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/services/hikaye_ekle_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

class WriterPage extends StatefulWidget {
  const WriterPage({super.key});

  @override
  State<WriterPage> createState() {
    return _WriterPageState();
  }
}

class _WriterPageState extends State<WriterPage> {
  @override
  TextEditingController hikayeBaslikController =
      TextEditingController(); //yarattığımız nesne ile textfield da
  TextEditingController hikayeMetinController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  HikayeEkle _hikayeEkle = HikayeEkle();
  FirebaseAuth auth = FirebaseAuth.instance;

  // TODO: implement widget
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hikayeni Oluşturmaya Başla"),
          backgroundColor: CustomColors.buttonTextColor,
        ),
        backgroundColor: CustomColors.girisEkranBackgroundColor,
        body: _yaziAlani());
  }

  Widget _yaziAlani() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  children: [
                    _customSizedBox(),
                    _baslikAlaniText(),
                    _customSizedBox(),
                    _metinAlaniText(),
                    _customSizedBox(),
                    _secenekEkleText(),
                    _customSizedBox(),
                  ],
                ),
                CustomTextButton(
                    onPressed: () {
                      _register();
                    },
                    buttonText: "Kaydet",
                    textColor: CustomColors.buttonBackColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _baslikAlaniText() {
    return Material(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
        child: TextField(
          controller: hikayeBaslikController,
          textInputAction: TextInputAction.next,
          maxLines: null,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: "Hikaye Başlığı"),
        ),
      ),
    );
  }

  Widget _secenekAlaniText() {
    return Material(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(300)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
        child: TextField(
          textInputAction: TextInputAction.done,
          maxLines: null,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: "Hikaye Başlığı"),
        ),
      ),
    );
  }

  Widget _metinAlaniText() {
    return Column(
      children: [
        Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 8, 230),
            child: TextField(
              controller: hikayeMetinController,
              textInputAction: TextInputAction.done,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Metin Alanı"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _secenekEkleText() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _secenekAlaniText();
        });
  }

  Widget _customSizedBox() => SizedBox(
        height: 30,
      );

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Kaydet"),
    );
  }

  _register() {
    FirebaseFirestore.instance.collection("Writers").doc().set({
      "kullaniciid": auth.currentUser!.uid,
      'title': hikayeBaslikController.text,
      'text': hikayeMetinController.text
    });
  }
}
