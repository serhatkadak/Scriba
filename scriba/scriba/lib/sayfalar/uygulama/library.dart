import 'package:flutter/material.dart';
import 'package:scriba/sayfalar/uygulama/library/fovorilerim_page.dart';
import 'package:scriba/sayfalar/uygulama/library/okuma_listem_page.dart';
import 'package:scriba/utils/customColors.dart';

import 'library/son_okunan_page.dart';

/// Flutter code sample for [TabBar].

void main() => runApp(const LibraryPage());

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: CustomColors.girisEkranBackgroundColor,
        appBar: AppBar(
          backgroundColor: CustomColors.girisEkranBackgroundColor,
          title: const Text(
            'Kitaplığım',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Son Okunan",
              ),
              Tab(
                text: "Okuma Listem",
              ),
              Tab(
                text: "Favorilerim",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[SonOkunanPage(), OkumaListem(), FavorilerimPage()],
        ),
      ),
    );
  }
}
