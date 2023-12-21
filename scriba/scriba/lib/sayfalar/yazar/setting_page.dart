import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/services/auth_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

import 'drawer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late String email, password, fullname, username;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  final formkey = GlobalKey<
      FormState>(); //dışarıdan form elemanlarını kontrol etmek için formkey oluşturduk
  final firebaseAuth =
      FirebaseAuth.instance; //firebase deki metotlara değişken ile erişiyoruz
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => YanMenu()));
          },
        ),
        backgroundColor: CustomColors.buttonTextColor,
        title: Text(
          "Hesap Bilgileri",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xfff4ede7),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: formkey, //formkey kullandık
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Column(
                    children: [
                      scribaText(),
                      customSizedBox(),
                      fullNameText(),
                      customSizedBox(),
                      userNameText(),
                      customSizedBox(),
                      emailText(),
                      customSizedBox(),
                      sifreText(),
                      customSizedBox(),
                      CustomTextButton(
                          onPressed: profilGuncelleme,
                          buttonText: "Güncelle",
                          textColor: CustomColors.buttonBackColor),
                      customSizedBox(),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  TextFormField sifreText() {
    return TextFormField(
      controller: passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz..."; //girilen değeri kontrol ediyoruz
        } else {}
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      decoration: girisEkrani("Şifre"),
    );
  }

  TextFormField emailText() {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz..."; //girilen değeri kontrol ediyoruz
        } else {}
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: girisEkrani("Email"),
    );
  }

  TextFormField fullNameText() {
    return TextFormField(
      controller: fullnameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz..."; //girilen değeri kontrol ediyoruz
        } else {}
      },
      onSaved: (value) {
        fullname = value!;
      },
      decoration: girisEkrani("Ad Soyad"),
    );
  }

  TextFormField userNameText() {
    return TextFormField(
      controller: usernameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz..."; //girilen değeri kontrol ediyoruz
        } else {}
      },
      onSaved: (value) {
        username = value!;
      },
      decoration: girisEkrani("Kullanıcı Adı"),
    );
  }

  Text scribaText() {
    return Text(
      "Hesap bilgilerini güncelleyebilirsin",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

  void profilGuncelleme() {
    FirebaseFirestore.instance
        .collection("Writers")
        .doc(
            "cK7UgbNvoozgZhkPhFR0") //bu şekilde bilgileri güncelliyoruz ama authentication'a yeni kullanıcı ekleyemiyoruz işlemi yapmıyor
        .update({
      'fullname': fullnameController.text,
      'username': usernameController.text,
      'email': emailController.text
    });
  }
}
