import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/uygulama/home/kitap_icerigi.dart';
import 'package:scriba/sayfalar/uygulama/home/hikaye_ozellikleri.dart';
import 'package:scriba/sayfalar/uygulama/seslendirme/dinle.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final kitap_gorseli = [
    'assets/images/tas-kentin-kronigi.jpg',
    'assets/images/munferit-bir-olay.jpg',
    'assets/images/sırali-sırasiz.jpg',
    'assets/images/buyuk-akil.jpg',
  ];

  String? title;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _pageController = PageController();
  final sizinIcinOnerilenlerList = HikayeOzellikleri.sizinIcinOnerilenler();
  final enCokOkunanlarList = HikayeOzellikleri.populerOlanlar();
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Anasayfa",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      backgroundColor: CustomColors.girisEkranBackgroundColor,
      body: ListView(
        children: [
          cokYakinda(),
          _category_title("Senin İçin Önerilenler"),
          onerilenlerMethod(),
          _category_title("En Çok Okunanlar"),
          enCokOkunanMethod()
        ],
      ),
    );
  }

  ListView enCokOkunanMethod() {
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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isBookmarked = true;
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc()
                                      .set({
                                    "kullaniciid": auth.currentUser!.uid,
                                    'okumaListem': gorsel.name,
                                    "okumaListemYazar": gorsel.auther,
                                    'okumaListemKisaOzet': gorsel.desc,
                                  });
                                });

                                Timer(Duration(seconds: 1), () {
                                  setState(() {
                                    isBookmarked = false;
                                  });
                                });
                              },
                              child: Icon(
                                Icons.bookmark_add,
                                color: isBookmarked
                                    ? Colors.green
                                    : Colors.orange[300],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isBookmarked = true;
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc()
                                      .set({
                                    "kullaniciid": auth.currentUser!.uid,
                                    'favorilerim': gorsel.name,
                                    "favorilerimYazar": gorsel.auther,
                                    'favorilerimKisaOzet': gorsel.desc,
                                  });
                                });

                                Timer(Duration(seconds: 1), () {
                                  setState(() {
                                    isBookmarked = false;
                                  });
                                });
                              },
                              child: Icon(
                                Icons.favorite,
                                color: isBookmarked
                                    ? Colors.green
                                    : Colors.orange[300],
                              ),
                            ),
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

  SizedBox onerilenlerMethod() {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20),
        itemBuilder: (_, index) {
          var gorsel = sizinIcinOnerilenlerList[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => KitapIcerik(gorsel),
                ),
              );
            },
            child: Stack(
              children: [
                SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            gorsel.imgUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Text(
                          gorsel.name!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          gorsel.auther!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: _buildIconText(
                    Icons.star,
                    Colors.orange[300]!,
                    '${gorsel.score}',
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, index) => const SizedBox(
          width: 15,
        ),
        itemCount: sizinIcinOnerilenlerList.length,
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

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
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
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }

  Container cokYakinda() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 15,
      ),
      height: 210,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: kitap_gorseli
                .map((e) => Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              e,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black.withOpacity(0),
                                    Colors.black12,
                                    Colors.black26,
                                    Colors.black38,
                                    Colors.black38,
                                    Colors.black38,
                                    Colors.black26,
                                    Colors.black12,
                                    Colors.black.withOpacity(0),
                                  ])),
                        ),
                        const Positioned(
                          left: 30,
                          top: 20,
                          child: Text(
                            'Çok Yakında\n Sizlerle Buluşuyor',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        const Positioned(
                          left: 30,
                          top: 160,
                          child: Text(
                            "Farklı maceralar ve hikayeleri\n siz sevgili okurlarımız Scriba'dan okuyabileceksiniz",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        )
                      ],
                    ))
                .toList(),
          ),
          Positioned(
            left: 30,
            bottom: 5,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: kitap_gorseli.length,
              effect: const ExpandingDotsEffect(
                expansionFactor: 4,
                dotWidth: 8,
                dotHeight: 8,
                spacing: 4,
                activeDotColor: Colors.white,
              ),
              onDotClicked: (index) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _category_title(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title = title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Daha Fazla",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
