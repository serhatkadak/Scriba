import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scriba/main.dart';
import 'package:scriba/sayfalar/uygulama/home/hikaye_ozellikleri.dart';

class Deneme extends StatelessWidget {
  const Deneme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Dinle()),
      ),
    );
  }
}

class Dinle extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  // speak(String text) async {
  //   await flutterTts.setLanguage("tr-TR");
  //   await flutterTts.setPitch(1.35);
  //   await flutterTts.speak(text);
  // }
  speakText(String text) async {
    await flutterTts.setVoice({"WaveNet": "tr-TR-Wavenet-E"});
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: textEditingController,
            ),
            ElevatedButton(
                onPressed: () => speakText(textEditingController.text),
                child: Text("Oku--  "))
          ],
        ),
      ),
    );
  }
}
