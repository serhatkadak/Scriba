import 'package:flutter/material.dart';
import 'package:scriba/utils/customColors.dart';

void main() {
  runApp(const OkumaListem());
}

class OkumaListem extends StatelessWidget {
  const OkumaListem({super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  'Herhangi bir okuma listen bulunmuyor. Hemen listeni oluşturmaya başla',
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
                'Okuma listelerin burada görünecek',
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
