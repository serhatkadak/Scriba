import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:scriba/sayfalar/uygulama/profile.dart';
import 'package:scriba/sayfalar/uygulama/search.dart';
import 'package:scriba/utils/customColors.dart';

import 'home.dart';
import 'library.dart';

class TapBarController extends StatefulWidget {
  const TapBarController({super.key});

  @override
  State<TapBarController> createState() => _TapBarControllerState();
}

class _TapBarControllerState extends State<TapBarController> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    aktifsekme = HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNavigationBar(),
      body: aktifsekme,
    );
  }

  Widget? aktifsekme;

  BottomNavigationBar customBottomNavigationBar() {
    return BottomNavigationBar(
        onTap: (int i) {
          switch (i) {
            case 0:
              setState(() {
                _currentIndex = 0;
                aktifsekme = HomePage();
              });
              break;
            case 1:
              setState(() {
                _currentIndex = 1;
                aktifsekme = SearchPage();
              });
              break;
            case 2:
              setState(() {
                _currentIndex = 2;

                aktifsekme = LibraryPage();
              });
              break;

            case 3:
              setState(() {
                _currentIndex = 3;
                aktifsekme = ProfilPage();
              });
              break;
          }
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: CustomColors.buttonTextColor,
        unselectedItemColor: CustomColors.buttonBackColor,
        items: [
          _customBottomNavigationBarItem(CupertinoIcons.app, "Anasayfa"),
          _customBottomNavigationBarItem(CupertinoIcons.search, "Ara"),
          _customBottomNavigationBarItem(CupertinoIcons.book, "Kütüphane"),
          _customBottomNavigationBarItem(CupertinoIcons.person, "Profil")
        ]);
  }

  BottomNavigationBarItem _customBottomNavigationBarItem(
          IconData iconData, String label) =>
      BottomNavigationBarItem(icon: Icon(iconData), label: label);
}
