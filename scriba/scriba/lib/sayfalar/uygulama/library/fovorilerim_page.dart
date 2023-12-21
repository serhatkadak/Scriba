import 'package:flutter/material.dart';
import 'package:scriba/utils/customColors.dart';

void main() {
  runApp(const FavorilerimPage());
}

class FavorilerimPage extends StatelessWidget {
  const FavorilerimPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Görünüşe göre favori hikayelerini  buraya eklemedin',
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
                'Favori  hikayelerin burada görünecek',
                textAlign: TextAlign.center,
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
                textAlign: TextAlign.center,
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
  }
}
