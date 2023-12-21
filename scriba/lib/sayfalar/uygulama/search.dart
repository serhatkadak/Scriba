import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/uygulama/home/tasks.dart';
import 'package:scriba/utils/customColors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.girisEkranBackgroundColor,
          title: Text(
            "Profil",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        backgroundColor: CustomColors.girisEkranBackgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              alignment: Alignment.topLeft,
            ),
            aramaCubugu(),
            SizedBox(
              height: 25,
            ),
            Expanded(child: Tasks())
          ],
        ));
  }

  Container aramaCubugu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 50),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: CustomColors.buttonTextColor,
                    size: 30,
                  ),
                  hintText: "Örn: Uyanış",
                  hintStyle: TextStyle(color: CustomColors.buttonTextColor)),
            ),
          ),
        ],
      ),
    );
  }
}
