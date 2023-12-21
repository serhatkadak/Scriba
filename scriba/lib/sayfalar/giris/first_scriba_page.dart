import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/services/auth_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

class FirstScribaPage extends StatefulWidget {
  const FirstScribaPage({Key? key}) : super(key: key);

  @override
  State<FirstScribaPage> createState() => _FirstScribaPageState();
}

class _FirstScribaPageState extends State<FirstScribaPage> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.girisEkranBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * .50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
            customSizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    customSizedBox(),
                    scriba(),
                    customSizedBox(),
                    customSizedBox(),
                    customSizedBox(),
                    CustomTextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/LoginPage");
                        },
                        buttonText: "Giriş Yap",
                        textColor: CustomColors.buttonBackColor),
                    CustomTextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/SignUp"),
                        buttonText: "Kayıt Ol",
                        textColor: CustomColors.buttonBackColor)
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void signIn() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final userResult = await authService.signIn(email, password);

      if (userResult == "basarili") {
        Navigator.pushReplacementNamed(context, "/homePage");
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Hata"),
                content: Text(userResult!),
                actions: [
                  TextButton(
                      onPressed: () {
                        return Navigator.pop(
                            context); //bir önceki sayfaya dönme
                      },
                      child: Text("Tamam"))
                ],
              );
            });
      }
    } else {}
  }

  Text scriba() {
    return Text(
      "Scriba'ya \nHoşgeldin",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget customSizedBox() => SizedBox(
        height: 20,
      );

  InputDecoration girisEkrani(String labelText) {
    return InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff3e200b)),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder());
  }
}
