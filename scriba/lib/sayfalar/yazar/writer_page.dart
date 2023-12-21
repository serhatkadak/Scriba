import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/sayfalar/yazar/writer_page_2.dart';
import 'package:scriba/services/hikaye_ekle_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

class WriterPage extends StatefulWidget {
  const WriterPage({Key? key}) : super(key: key);

  @override
  State<WriterPage> createState() => _WriterPageState();
}

class _WriterPageState extends State<WriterPage> {
  final List<TextEditingController> _textControllers = [];
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  HikayeEkle _hikayeEkle = HikayeEkle();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController hikayeBaslikController = TextEditingController();
  TextEditingController hikayeMetinController = TextEditingController();
  int _textFieldCount = 0;

  void _addTextField() {
    if (_textFieldCount < 3) {
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
        title: Text("Hikayeni Oluşturmaya Başla"),
        backgroundColor: CustomColors.buttonTextColor,
      ),
      backgroundColor: CustomColors.girisEkranBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _baslikAlaniText(),
              _customSizedBox(),
              _metinAlaniText(),
              _customSizedBox(),
              for (var controller in _textControllers) ...[
                _customSizedBox(),
                _textFormField(controller),
              ],
              _customSizedBox(),
              if (_textFieldCount < 2) ...[
                FloatingActionButton(
                  onPressed: _addTextField,
                  child: Icon(Icons.add),
                ),
              ],
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 280),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _register();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WriterPage2(),
                          ),
                        );
                      },
                      child: Icon(Icons.forward)),
                ],
              ),
              _customSizedBox(),
              CustomTextButton(
                onPressed: () {
                  _register();
                },
                buttonText: "Kaydet",
                textColor: CustomColors.buttonBackColor,
              ),
            ],
          ),
        ),
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
            border: InputBorder.none,
            hintText: "Hikaye Başlığı",
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
          controller: hikayeMetinController,
          textInputAction: TextInputAction.done,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Hikayeni Oluşturmaya Başla",
          ),
        ),
      ),
    );
  }

  Widget _textFormField(TextEditingController controller) {
    return Material(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.done,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Seçenek",
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
      'title': hikayeBaslikController.text,
      'girisText': hikayeMetinController.text,
      'olumluSecenek1':
          _textControllers.length > 0 ? _textControllers[0].text : '',
      'olumsuzSecenek1':
          _textControllers.length > 1 ? _textControllers[1].text : '',
    });

    setState(() {
      _textControllers.clear();
      _textFieldCount = 0;
    });
  }
}
