import 'package:flutter/material.dart';
import 'package:scriba/sayfalar/uygulama/home/kitap_icerigi.dart';
import 'package:scriba/sayfalar/yazar/drawer.dart';
import 'package:scriba/sayfalar/yazar/writer_page.dart';
import 'package:scriba/services/deneme.dart';
import 'package:scriba/services/hikaye_ekle_services.dart';
import 'package:scriba/utils/customColors.dart';

import '../../widgets/custom_text_button.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  HikayeEkle _hikayeEkle = HikayeEkle();
  TextEditingController hikayeAdiController = TextEditingController();
  TextEditingController hikayeYazariController = TextEditingController();
  TextEditingController hikayeKisaOzetController = TextEditingController();
  TextEditingController hikayeTurController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => YanMenu()));
          },
        ),
        backgroundColor: CustomColors.buttonTextColor,
        title: Text(
          "Hikaye Bilgilerini Ekle",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _hikayeAdiWidget("Hikaye Adı"),
              SizedBox(height: 16.0),
              _hikayeYazariWidget("Hikaye Yazarı"),
              SizedBox(height: 16.0),
              _hikayeKisaOzetWidget("Hikaye Kısa Özeti"),
              SizedBox(height: 16.0),
              _hikayeTurWidget("Hikaye Türü"),
              SizedBox(height: 16.0),
              CustomBuildButton(
                  onPressed: () {
                    _hikayeEkle.addHikaye(
                        hikayeAdiController.text,
                        hikayeYazariController.text,
                        hikayeKisaOzetController.text,
                        hikayeTurController.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WriterPage(),
                      ),
                    );
                  },
                  buttonText: "Hikayeni oluştur",
                  textColor: Colors.grey,
                  icon: Icon(Icons.next_plan),
                  buttonColor: CustomColors.buttonBackColor)
            ],
          ),
        ),
      ),
    );
  }

  Widget _hikayeAdiWidget(String labelText) {
    return TextFormField(
      controller: hikayeAdiController,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _hikayeYazariWidget(String labelText) {
    return TextFormField(
      controller: hikayeYazariController,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _hikayeKisaOzetWidget(String labelText) {
    return TextFormField(
      controller: hikayeKisaOzetController,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _hikayeTurWidget(String labelText) {
    return TextFormField(
      controller: hikayeTurController,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
