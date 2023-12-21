import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/uygulama/home/hikaye_ozellikleri.dart';
import 'package:scriba/sayfalar/uygulama/home/kitap_icerigi.dart';

class Kitaplarim extends StatelessWidget {
  final enCokOkunanlarList = HikayeOzellikleri.populerOlanlar();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final gorsel = enCokOkunanlarList[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => KitapIcerik(gorsel),
              ),
            );
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                gorsel.name!,
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
                          gorsel.auther!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          gorsel.desc!,
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
        );
      },
      separatorBuilder: (_, index) => const SizedBox(
        width: 15,
      ),
      itemCount: enCokOkunanlarList.length,
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
