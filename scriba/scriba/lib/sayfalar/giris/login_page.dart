import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scriba/services/auth_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                key: formkey,
                child: Column(
                  children: [
                    scriba(),
                    customSizedBox(),
                    emailText(),
                    customSizedBox(),
                    sifreText(),
                    sifremiUnuttum(),
                    customSizedBox(),
                    CustomTextButton(
                        onPressed: signIn,
                        buttonText: "Giriş Yap",
                        textColor: CustomColors.buttonBackColor),
                    CustomTextButton(
                        onPressed: writerSignIn,
                        buttonText: "Yazar Girişi",
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

  // Center girisYap() {
  //   return Center(
  //     child: TextButton(
  //       onPressed: signIn,
  //       child: Container(
  //         height: 50,
  //         width: 150,
  //         margin: EdgeInsets.symmetric(horizontal: 50),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadiusDirectional.circular(50),
  //             color: CustomColors.buttonTextColor),
  //         child: Center(
  //           child: Text(
  //             "Giriş Yap",
  //             style: TextStyle(color: CustomColors.buttonBackColor),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void signIn() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final userResult = await authService.signIn(email, password);

      if (userResult == "basarili") {
        Navigator.pushReplacementNamed(context, "/tapBarPage");
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

  void writerSignIn() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final writerResult = await authService.signIn(email, password);

      if (writerResult == "basarili") {
        Navigator.pushReplacementNamed(context, "/drawerPage");
      }
      //hocaya yazar olarak girişi sor
      else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Hata"),
                content: Text(writerResult!),
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
  // void signIn() async {
  //   if (formkey.currentState!.validate()) {
  //     formkey.currentState!.save();
  //     try {
  //       final userResult = await firebaseAuth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //       Navigator.pushReplacementNamed(context, "/homePage");
  //       print(userResult.user!.email);
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //   } else {}
  // }

  // Center kayitOl() {
  //   return Center(
  //     child: TextButton(
  //       onPressed: () => Navigator.pushNamed(context, "/SignUp"),
  //       child: Container(
  //         height: 50,
  //         width: 150,
  //         margin: EdgeInsets.symmetric(horizontal: 50),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadiusDirectional.circular(50),
  //             color: Color(0xffa06349)),
  //         child: Center(
  //           child: Text(
  //             "Kayıt Ol",
  //             style: TextStyle(color: Color(0xff3e200b)),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Row sifremiUnuttum() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MaterialButton(
          child: Text("Şifremi Unuttum"),
          onPressed: () {},
        )
      ],
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
