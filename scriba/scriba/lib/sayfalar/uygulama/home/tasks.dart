import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final katagoriList = Katagori.Katagori_();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 500,
      child: GridView.builder(
          itemCount: katagoriList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 120),
          itemBuilder: (context, index) => katagoriList[index].isLast
              ? _buildTask1()
              : _buildTask(context, katagoriList[index])),
    );
  }

  Widget _buildTask1() {
    return Text(" ");
  }

  Widget _buildTask(BuildContext context, Katagori katagori) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: katagori.color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            katagori.tur!,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class Katagori {
  String? tur;
  Color? color;
  bool isLast;
  Katagori({this.tur, this.color, this.isLast = false});

  static List<Katagori> Katagori_() {
    return [
      Katagori(tur: "Polisiye", color: Colors.blueAccent),
      Katagori(tur: "Çocuk", color: Colors.teal),
      Katagori(tur: "Tarih", color: Colors.purpleAccent),
      Katagori(tur: "Gençlik", color: Colors.lime),
      Katagori(tur: "Aksiyon", color: Colors.red),
      Katagori(tur: "Macera", color: Colors.indigo),
      Katagori(tur: "Seslendirme", color: Colors.orange),
      Katagori(tur: "Öykü", color: Colors.grey),
      Katagori(isLast: true)
    ];
  }
}
