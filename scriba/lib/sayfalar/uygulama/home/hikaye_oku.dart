import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/uygulama/home/hikaye_oku2.dart';
import 'package:scriba/widgets/custom_text_button.dart';

import '../../../utils/customColors.dart';

class HikayeOku extends StatelessWidget {
  const HikayeOku({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('Writers')
          .where('title', isEqualTo: '1.Bölüm')
          .limit(1)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Yüklenirken gösterilecek widget
        }

        if (snapshot.hasError) {
          return Text('Veri alınamadı: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('Veri bulunamadı.');
        }

        final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
        final girisText = data['girisText'] ?? '';
        final olumluSecenek1 = data['olumluSecenek1'] ?? '';
        final olumsuzSecenek1 = data['olumsuzSecenek1'] ?? '';

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
                      girisText,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HikayeOku2(
                              buttonTextGonderilen: olumluSecenek1,
                            ),
                          ),
                        );
                      },
                      buttonText: olumluSecenek1,
                      textColor: CustomColors.buttonBackColor,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HikayeOku2(
                              buttonTextGonderilen: olumsuzSecenek1,
                            ),
                          ),
                        );
                      },
                      buttonText: olumsuzSecenek1,
                      textColor: CustomColors.buttonBackColor,
                    ),
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
