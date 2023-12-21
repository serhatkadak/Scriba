import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scriba/sayfalar/yazar/kitaplar%C4%B1m.dart';
import 'package:scriba/sayfalar/yazar/writer_page.dart';
import 'package:scriba/services/auth_services.dart';
import 'package:scriba/utils/customColors.dart';
import 'package:scriba/utils/images.dart';
import '../giris/login_page.dart';
import 'kitaplarim2.dart';

class YanMenu extends StatefulWidget {
  @override
  _YanMenuState createState() => _YanMenuState();
}

class _YanMenuState extends State<YanMenu> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.buttonTextColor,
          title: Text("Yazar Profil Sayfası"),
        ),
        backgroundColor: CustomColors.girisEkranBackgroundColor,
        body: WritersStoryList(),
        drawer: _buildDrawer());
  }

  Widget _buildBody() {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: _buildCard(index),
      ),
      itemCount: 5,
    );
  }

  Widget _buildCard(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("Not $index"),
      ),
    );
  }

  void _anasayfa() {
    Navigator.pop(context);
  }

  void _profil() {
    Navigator.pushReplacementNamed(context, "/yazarProfilPage");
  }

  void _yazilarim() {
    Navigator.pushReplacementNamed(context, "/storyPage");
  }

  void _ayarlar() {
    Navigator.pushReplacementNamed(context, "/settingPage");
  }

  void _cikis() {
    authService.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    ;
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildTitle('Kitaplarım', Icons.menu_book, _anasayfa),
          Divider(),
          _buildTitle('Profil', Icons.person, _profil),
          Divider(),
          _buildTitle('Hikaye Oluştur', Icons.abc, _yazilarim),
          Divider(),
          _buildTitle('Hesap', Icons.account_circle, _ayarlar),
          Divider(),
          _buildTitle('Çıkış Yap', Icons.logout, _cikis),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: CustomColors.buttonTextColor),
      accountName: Text("Serhat"),
      accountEmail: Text("serhat@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage(scribaLogo),
      ),
    );
  }

  Widget _buildTitle(String text, IconData, Function function) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        IconData,
        color: CustomColors.buttonTextColor,
      ),
      onTap: () {
        function();
      },
    );
  }
}
