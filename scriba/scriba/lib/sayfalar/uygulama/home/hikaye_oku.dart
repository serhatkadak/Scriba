import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../utils/customColors.dart';

class HikayeOku extends StatelessWidget {
  const HikayeOku({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Container(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                Text(
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.'
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.'
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.'
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.'
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.'
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.'
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.'
                  'Hikaye metni burada yer alacak. '
                  'Dilediğiniz kadar uzun olabilir.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
