import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/services/auth_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email, password, fullname, username, bio;

  final formkey = GlobalKey<
      FormState>(); //dışarıdan form elemanlarını kontrol etmek için formkey oluşturduk
  final firebaseAuth =
      FirebaseAuth.instance; //firebase deki metotlara değişken ile erişiyoruz
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff4ede7),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * .30,
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
                key: formkey, //formkey kullandık
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
                    bioText(),
                    customSizedBox(),
                    CustomTextButton(
                        onPressed: signUp,
                        buttonText: "Kayıt Ol",
                        textColor: CustomColors.buttonBackColor),
                    //kayitOlText(),
                    CustomTextButton(
                        onPressed: writerSignUp,
                        buttonText: "Yazar Olarak Kayıt Ol",
                        textColor: CustomColors.buttonBackColor),
                    customSizedBox(),
                    geriDonText()
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void signUp() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final result =
          await authService.signUp(email, username, fullname, password, bio);
      if (result == "basarili") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
        formkey.currentState!
            .reset(); // kayitt ol formdaki verileri resetliyoruz
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Scriba'ya Hoşgeldin... Lütfen Giriş Yapmak Email ve Şifrenizi Giriniz..."),
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Hata"),
                content: Text(result!),
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

  void writerSignUp() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final result = await authService.writerSignUp(
          email, username, fullname, password, bio);
      if (result == "writerbasarili") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
        formkey.currentState!
            .reset(); // kayit ol formdaki verileri resetliyoruz
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Sevgili Scriba Yazarı Aramıza Hoşgeldin... Lütfen Giriş Yapmak Email ve Şifrenizi Giriniz..."),
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Hata"),
                content: Text(result!),
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

  Center geriDonText() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/LoginPage"),
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(50),
              color: Color(0xffa06349)),
          child: Center(
            child: Text(
              "Giriş Sayfasına Dön",
              style: TextStyle(color: Color(0xff3e200b)),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField sifreText() {
    return TextFormField(
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

  TextFormField bioText() {
    return TextFormField(
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz..."; //girilen değeri kontrol ediyoruz
        } else {}
      },
      onSaved: (value) {
        bio = value!;
      },
      decoration: girisEkrani("Hakkımda"),
    );
  }

  Text scribaText() {
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
