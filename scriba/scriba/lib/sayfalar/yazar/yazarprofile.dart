import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/giris/login_page.dart';
import 'package:scriba/sayfalar/uygulama/profile/profile_settings.dart';
import 'package:scriba/services/auth_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

import 'drawer.dart';

class YazarProfilPage extends StatefulWidget {
  const YazarProfilPage({super.key});

  @override
  State<YazarProfilPage> createState() => _YazarProfilPageState();
}

class _YazarProfilPageState extends State<YazarProfilPage> {
  AuthService authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Writers')
          .where('kullaniciid', isEqualTo: auth.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          for (var document in documents) {
            String username = document['username'];
            String fullname = document['fullname'];
            String email = document['email'];
            String bio = document['bio'];

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => YanMenu()));
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
                backgroundColor: CustomColors.girisEkranBackgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16.0),
                      Center(child: profileIcon()),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '$fullname',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'Email: $email',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Kullanıcı Adı: $username',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 18.0),
                            Text(
                              'Hakkımda',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '$bio',
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 20),
                              child: Column(
                                children: [
                                  buildIconAndText(Icon(Icons.question_mark),
                                      'Yardım Merkezi'),
                                  GestureDetector(
                                      onTap: () {
                                        authService.signOut();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      child: buildIconAndText(
                                          Icon(Icons.logout), 'Çıkış Yap')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        } else {
          return CircularProgressIndicator(); // Veri yüklenene kadar bekletme göstergesi
        }
      },
    );
  }

  GestureDetector buildIconAndText(
    Icon icon,
    String text,
  ) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Container(
              child: icon,
              width: 50,
              height: 50,
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[400]),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container profileIcon() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Icon(
        Icons.edit,
        color: Colors.red[400],
        size: 30,
      ),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(
              image: const AssetImage("assets/images/6.png"))),
    );
  }
}

/* 


return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        backgroundColor: CustomColors.girisEkranBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              Center(child: profileIcon()),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ad Soyad',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'email',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Takipçiler',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          '10K',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 32.0),
                        Text(
                          'Takip Edilen',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          '1K',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Hakkımda',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Merhaba! Benim adım Ad Soyad ve mesleğimle ilgili birkaç cümle buraya yazabilirim. '
                      'Hobilerim, ilgi alanlarım ve deneyimlerim hakkında kısa bir bilgi verebilirim.',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      child: Column(
                        children: [
                          buildIconAndText(
                              Icon(Icons.question_mark), 'Yardım Merkezi'),
                          GestureDetector(
                              onTap: () {
                                authService.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: buildIconAndText(
                                  Icon(Icons.logout), 'Çıkış Yap')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );


*/