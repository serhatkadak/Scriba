import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scriba/sayfalar/uygulama/profile.dart';
import 'package:scriba/sayfalar/uygulama/search.dart';
import 'package:scriba/sayfalar/uygulama/search/bulunan_hikaye.dart';
import 'package:scriba/sayfalar/uygulama/search/hikaye_getir.dart';

import '../../utils/customColors.dart';
import 'home/tasks.dart';

class SearchDenemePage extends StatefulWidget {
  const SearchDenemePage({Key? key}) : super(key: key);

  @override
  State<SearchDenemePage> createState() => _SearchDenemePageState();
}

class _SearchDenemePageState extends State<SearchDenemePage> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  bool _isSearching = false;
  List<String> _searchedQueries = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.girisEkranBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            alignment: Alignment.topLeft,
            child: Text(
              'Kategoriler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          aramaCubugu(),
          SizedBox(height: 25),
          Expanded(
            child: _isSearching ? buildSearchResults() : Tasks(),
          ),
        ],
      ),
    );
  }

  Container aramaCubugu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 50),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (query) => _startSearch(query),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: CustomColors.buttonTextColor,
                  size: 30,
                ),
                hintText: "Örn: Uyanış",
                hintStyle: TextStyle(color: CustomColors.buttonTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _isSearching = true;
        if (!_searchedQueries.contains(query)) {
          _searchedQueries.add(query);
          performSearch(query);
        }
      } else {
        _isSearching = false;
      }
    });
  }

  void performSearch(String query) {
    final CollectionReference writersCollection =
        FirebaseFirestore.instance.collection('Writers');

    writersCollection
        .where('hikayeAdi', isGreaterThanOrEqualTo: query)
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        _searchResults = querySnapshot.docs;
      });
    });
  }

  void navigateToDetailPage(String hikayeAdi) {
    // Burada yönlendirme işlemini gerçekleştirebilirsiniz
    // Örnek olarak, seçilen öğenin hikayeAdi değerini yazdıralım
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => HikayeGetir(
    //       hikayeAdi: hikayeAdi,
    //     ),
    //   ),
    // );
  }

  Widget buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (BuildContext context, int index) {
        final DocumentSnapshot document = _searchResults[index];
        final Map<String, dynamic>? data =
            document.data() as Map<String, dynamic>?;

        if (data == null) {
          return SizedBox(); // veya başka bir yerleştirme widget'i döndürebilirsiniz
        }

        final String hikayeAdi = data['hikayeAdi'];

        return ListTile(
          title: InkWell(
            onTap: () {
              navigateToDetailPage(hikayeAdi);
            },
            child: Text(hikayeAdi),
          ),
        );
      },
    );
  }
}
