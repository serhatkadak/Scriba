import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scriba/sayfalar/giris/first_scriba_page.dart';
import 'package:scriba/sayfalar/uygulama/home/hikaye_oku.dart';
import 'package:scriba/sayfalar/uygulama/library.dart';
import 'package:scriba/sayfalar/uygulama/profile.dart';
import 'package:scriba/sayfalar/uygulama/profile/profile_settings.dart';
import 'package:scriba/sayfalar/uygulama/seslendirme/dinle.dart';
import 'package:scriba/sayfalar/yazar/hikayeozellik.dart';
import 'package:scriba/sayfalar/yazar/setting_page.dart';
import 'package:scriba/sayfalar/yazar/writer_page.dart';
import 'package:scriba/sayfalar/giris/login_page.dart';
import 'package:scriba/sayfalar/giris/sign_up.dart';
import 'package:scriba/sayfalar/yazar/drawer.dart';
import 'package:scriba/sayfalar/uygulama/tap_bar_controller.dart';
import 'package:scriba/sayfalar/yazar/yazarprofile.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        "/firstScribaPage": (context) => FirstScribaPage(),
        "/LoginPage": (context) => LoginPage(),
        "/SignUp": (context) => SignUp(),
        "/drawerPage": (context) => YanMenu(),
        "/writerPage": (context) => WriterPage(),
        "/storyPage": (context) => StoryPage(),
        "/tapBarPage": (context) => TapBarController(),
        "/settingPage": (context) => SettingPage(),
        "/profilPage": (context) => ProfilPage(),
        "/profilPageSettings": (context) => ProfilePageSetting(),
        "/libraryPage": (context) => LibraryPage(),
        "/yazarProfilPage": (context) => YazarProfilPage(),
        "/hikayeOku": (context) =>
            HikayeOku() //anahtar kelime ile sayfalar arası geçiş
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: LoginPage(),
      home: FirstScribaPage(),
      //home: TapBarController(),
      //home: WriterPage(),
      //home: YanMenu(),
      //home: Deneme(),
    );
  }
}
