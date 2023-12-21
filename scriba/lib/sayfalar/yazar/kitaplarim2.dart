import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:scriba/sayfalar/uygulama/home/kitap_icerigi.dart';
import 'package:scriba/services/deneme.dart';
import 'package:scriba/services/hikaye_ekle_services.dart';

import '../uygulama/home/hikaye_ozellikleri.dart';

class WritersStoryList extends StatefulWidget {
  const WritersStoryList({super.key});

  @override
  State<WritersStoryList> createState() => _WritersStoryListState();
}

class _WritersStoryListState extends State<WritersStoryList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  HikayeEkle _hikayeEkle = HikayeEkle();
  final enCokOkunanlarList = HikayeOzellikleri.populerOlanlar();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Writers')
          .where('kullaniciid',
              isEqualTo: auth
                  .currentUser!.uid) // Burada kullanıcının UID'sini kullandık
          .where('hikayeAdi',
              isNull: false) // hikayeAdi alanı dolu olan belgeleri alır

          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Veri alınamadı: ${snapshot.error}');
        } else {
          var documents = snapshot.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (contex, index) {
                var data = documents[index].data();
                // Verileri kullanarak görselleştirme işlemlerini yapabilirsiniz
                var hikayeAdi = data['hikayeAdi'];
                var hikayeYazar = data['hikayeYazar'];
                var hikayeKisaOzet = data['hikayeKisaOzet'];
                final gorsel =
                    enCokOkunanlarList[index % enCokOkunanlarList.length];

                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {
                      /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KitapIcerik(gorsel),
                      ),
                    );
                    */
                    },
                    child: SizedBox(
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
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
