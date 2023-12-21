import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/uygulama/home/hikaye_ozellikleri.dart';
import 'package:scriba/sayfalar/uygulama/home.dart';
import 'package:scriba/sayfalar/uygulama/seslendirme/dinle.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

import 'hikaye_oku.dart';

class KitapIcerik extends StatelessWidget {
  final HikayeOzellikleri kitap;
  const KitapIcerik(this.kitap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 450,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: Image.asset(
                    kitap.imgUrl!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300], shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  kitap.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25, height: 1.2),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                kitap.auther!,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconText1(
                    Icons.star,
                    Colors.orange[300]!,
                    '${kitap.score}(${kitap.review}k)',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  _buildIconText1(
                    Icons.visibility,
                    Colors.grey[800]!,
                    '${kitap.view}m',
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: kitap.type!
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Chip(
                          backgroundColor: Colors.grey[200],
                          label: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomBuildButton(
                  onPressed: () {},
                  buttonText: "Dinle",
                  textColor: Colors.white70,
                  icon: Icon(
                    Icons.headphones,
                    size: 18,
                  ),
                  buttonColor: Colors.grey[600]!),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(kitap.desc!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBuildButton(
                        onPressed: () {},
                        buttonText: "Kitaplığıma Ekle",
                        textColor: Colors.white70,
                        icon: Icon(
                          Icons.add,
                          size: 18,
                        ),
                        buttonColor: Colors.grey[600]!),
                    // _buildButton(
                    //     Icons.add, Colors.grey[600]!, 'Kitaplığıma Ekle'),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomBuildButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/hikayeOku"),
                        buttonText: "Okumaya Başla",
                        textColor: Colors.white70,
                        icon: Icon(
                          Icons.menu_book,
                          size: 18,
                        ),
                        buttonColor: CustomColors.buttonTextColor),
                  ],
                ),
              ),
            ],
          ),
        ],
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

class CustomBuildButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  final Icon icon;
  const CustomBuildButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      required this.textColor,
      required this.icon,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 5,
            ),
            Text(
              buttonText,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
