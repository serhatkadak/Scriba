import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home/hikaye_ozellikleri.dart';

class HikayeGetir extends StatelessWidget {
  final String hikayeAdi;

  const HikayeGetir({required this.hikayeAdi});

  @override
  Widget build(BuildContext context) {
    final enCokOkunanlarList = HikayeOzellikleri.populerOlanlar();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Writers')
            .where('hikayeAdi', isEqualTo: hikayeAdi)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text('Veri alınamadı: ${snapshot.error}');
          }

          var documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return Center(
              child: Text('Hikaye bulunamadı.'),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var data = documents[index].data();
              // Verileri kullanarak görselleştirme işlemlerini yapabilirsiniz
              var hikayeAdi = data['hikayeAdi'];
              var hikayeYazar = data['hikayeYazar'];
              var hikayeKisaOzet = data['hikayeKisaOzet'];
              final gorsel =
                  enCokOkunanlarList[index % enCokOkunanlarList.length];

              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
              );
            },
          );
        },
      ),
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
