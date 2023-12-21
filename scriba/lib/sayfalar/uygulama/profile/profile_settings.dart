import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../utils/customColors.dart';

class ProfilePageSetting extends StatefulWidget {
  const ProfilePageSetting({super.key});

  @override
  State<ProfilePageSetting> createState() => _ProfilePageSettingState();
}

class _ProfilePageSettingState extends State<ProfilePageSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.girisEkranBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Profil Ayarları",
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [Text("helllaaaaaaa")],
        ),
      ),
    );
  }
}
