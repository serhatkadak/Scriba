import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../utils/customColors.dart';
import '../../../widgets/custom_text_button.dart';

class KayipTaksiler extends StatefulWidget {
  const KayipTaksiler({super.key});

  @override
  _KayipTaksilerState createState() => _KayipTaksilerState();
}

class _KayipTaksilerState extends State<KayipTaksiler> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> speak(String text) async {
    await flutterTts
        .setLanguage('tr-TR'); // Seslendirmede kullanılacak dil ayarı
    await flutterTts.setSpeechRate(0.8); // Ses hızı ayarı (0.5 normal hız)
    await flutterTts.setVolume(1); // Ses düzeyi ayarı (0.0 - 1.0 arası)
    await flutterTts.setPitch(1.1); // Ses tonu ayarı (0.5 - 2.0 arası)
    await flutterTts.speak(text); // Metni seslendirme
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Writers')
          .doc('dAIfQ8yo9dw7R3bjcjGT')
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Veri alınamadı: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Text('Veri bulunamadı.');
        }

        final data = snapshot.data!;
        final girisText = data['girisText'] ?? '';

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: CustomColors.girisEkranBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.0),
                      Text(
                        girisText,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 50),
                      CustomTextButton(
                        onPressed: () => speak(girisText),
                        buttonText: 'Metni Seslendir',
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
