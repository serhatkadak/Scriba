import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future forgotPassword(String email) async {
    try {
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
      print("Lütfen Email'inizi kontrol ediniz...");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> signIn(String email, String password) async {
    String? kont;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      kont = "basarili";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          kont = "Hatalı Email ";
          break;
        case "wrong-password":
          kont = "Şifreniz Hatalı";
          break;
        case "user-disabled":
          kont = "Kullanıcı Bulunamadı";
          break;
        default:
          kont =
              "Beklenmeyen Bir Durum İle Karşılaşıldı, Lütfen Tekrar Deneyin";
          break;
      }
    }
    return kont;
  }

  Future<String?> writerSignIn(String email, String password) async {
    String? kont;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      kont = "writerbasarili";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          kont = "Hatalı Email ";
          break;
        case "wrong-password":
          kont = "Şifreniz Hatalı";
          break;
        case "user-disabled":
          kont = "Kullanıcı Bulunamadı";
          break;
        default:
          kont =
              "Beklenmeyen Bir Durum İle Karşılaşıldı, Lütfen Tekrar Deneyin";
          break;
      }
    }
    return kont;
  }

  Future<String?> signUp(String email, String username, String fullname,
      String password, String bio) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        final ress = firebaseFirestore.collection("Users");
        final resultData = await ress.add({
          "kullaniciid": auth.currentUser!.uid,
          "email": email,
          "fullname": fullname,
          "username": username,
          "bio": bio,
        });
      } catch (e) {
        print("$e");
      }
      res = "basarili";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          res = "Mail Zaten Kayitli.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          res = "Gecersiz Mail";
          break;
        default:
          res = "Bir Hata Ile Karsilasildi, Birazdan Tekrar Deneyiniz.";
          break;
      }
    }
    return res;
  }

  Future<String?> writerSignUp(String email, String username, String fullname,
      String password, String bio) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        final ress = firebaseFirestore.collection("Writers");
        final resultData = await ress.add({
          "kullaniciid": auth.currentUser!.uid,
          "email": email,
          "fullname": fullname,
          "username": username,
          "bio": bio,
        });
      } catch (e) {
        print("$e");
      }
      res = "writerbasarili";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          res = "Mail Zaten Kayitli.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          res = "Gecersiz Mail";
          break;
        default:
          res = "Bir Hata Ile Karsilasildi, Birazdan Tekrar Deneyiniz.";
          break;
      }
    }
    return res;
  }

  //benim yaptığım
  // Future<String?> signUp(
  //     String email, String password, String username, String fullname) async {
  //   String? kont;
  //   try {
  //     final result = await firebaseAuth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     try {
  //       final resultData = await firebaseFirestore.collection("deneme").add({
  //         "email": email,
  //         "fullname": fullname,
  //         "username": username,
  //         // "story": [],
  //         // "koleksiyon": [],
  //         // "followers": [],
  //         // "bio": " "
  //       });
  //     } catch (e) {
  //       print("$e");
  //     }
  //     kont = "basarili";
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case "email-already-in-use":
  //         kont = "Bu Email Sistemde Kayıtlı";
  //         break;
  //       case "ERROR_INVALID_EMAIL":
  //       case "invalid-email":
  //         kont = "Geçersiz Mail";
  //         break;
  //       default:
  //         kont =
  //             "Beklenmeyen Bir Durum İle Karşılaşıldı, Lütfen Tekrar Deneyin";
  //         break;
  //     }
  //   }
  //   return kont;
  // }

  signOut() async {
    return await firebaseAuth.signOut();
  }
}
