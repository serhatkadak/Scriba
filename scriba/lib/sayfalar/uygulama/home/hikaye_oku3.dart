import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/uygulama/home.dart';
import 'package:scriba/widgets/custom_text_button.dart';

import '../../../utils/customColors.dart';

class HikayeOku3 extends StatelessWidget {
  final String buttonTextGonderilen;
  const HikayeOku3({super.key, required this.buttonTextGonderilen});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Writers')
          .doc('zLekV8qzxAYUhLkHUl7k') //bu kısım güncellenecek
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Yüklenirken gösterilecek widget
        }

        if (snapshot.hasError) {
          return Text('Veri alınamadı: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Text('Veri bulunamadı.');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final olumluText2 = data['olumluText2'] ?? '';
        final olumsuzText2 = data['olumsuzText2'] ?? '';

        final olumluSecenek2 = data['olumluSecenek2'] ?? '';
        final olumsuzSecenek2 = data['olumsuzSecenek2'] ?? '';

        String textToShow;
        if (buttonTextGonderilen == olumluSecenek2) {
          textToShow = olumluText2;
        } else if ((buttonTextGonderilen == olumsuzSecenek2)) {
          textToShow = olumsuzText2;
        } else {
          textToShow = ' ';
        }

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
                      textToShow,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomTextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                        buttonText: "Ana Sayfaya Dön",
                        textColor: CustomColors.buttonTextColor)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            color: Color(0xffa06349)),
        child: Center(
          child: Text(
            maxLines: null,
            buttonText,
            style: TextStyle(color: Colors.grey[300]),
          ),
        ),
      ),
    );
  }
}
