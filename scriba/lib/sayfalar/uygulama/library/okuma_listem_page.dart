import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/utils/customColors.dart';

import '../home/hikaye_ozellikleri.dart';
import '../home/kitap_icerigi.dart';

void main() {
  runApp(const OkumaListem());
}

class OkumaListem extends StatelessWidget {
  const OkumaListem({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    final enCokOkunanlarList = HikayeOzellikleri.populerOlanlar();

    return StreamBuilder(
      stream: _firestore
          .collection('Users')
          .where('kullaniciid', isEqualTo: auth.currentUser!.uid)
          .where('okumaListem', isNull: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Veri alınamadı: ${snapshot.error}');
        } else if (snapshot.data!.docs.isEmpty) {
          return Scaffold(
            backgroundColor: CustomColors.girisEkranBackgroundColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Column(
                  children: const <Widget>[
                    Icon(Icons.menu_book_sharp, color: Colors.red, size: 50),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: Text(
                        'Herhangi bir okuma listen bulunmuyor. Hemen listeni oluşturmaya başla',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Okuma listelerin burada görünecek',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Scribadaki hikayeleri keşfet",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          var documents = snapshot.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (contex, index) {
                var data = documents[index].data();

                var hikayeAdi = data['okumaListem'];
                var hikayeYazar = data['okumaListemYazar'];
                var hikayeKisaOzet = data['okumaListemKisaOzet'];
                final gorsel =
                    enCokOkunanlarList[index % enCokOkunanlarList.length];

                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(gorsel.imgUrl!),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "$hikayeAdi",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.bookmark_add,
                                        color: Colors.orange[300],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "$hikayeYazar",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "$hikayeKisaOzet",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildIconText1(
                                        Icons.star,
                                        Colors.orange[300]!,
                                        '${gorsel.score}(${gorsel.review}k)',
                                      ),
                                      const SizedBox(
                                        width: 95,
                                      ),
                                      _buildIconText1(
                                        Icons.visibility,
                                        Colors.grey,
                                        '${gorsel.view}k Okundu)',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }

  Widget _buildIconText1(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        )
      ],
    );
  }
}


/* return Scaffold(
      backgroundColor: CustomColors.girisEkranBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: const <Widget>[
              Icon(Icons.menu_book_sharp, color: Colors.red, size: 50),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  'Herhangi bir okuma listen bulunmuyor. Hemen listeni oluşturmaya başla',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Okuma listelerin burada görünecek',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Scribadaki hikayeleri keşfet",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ); */