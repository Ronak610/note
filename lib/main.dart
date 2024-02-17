
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:note_01/CREATE/Create_Page.dart';
import 'package:note_01/Home/View/Home_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  final remoteConfig = FirebaseRemoteConfig.instance;
  // remoteConfig.setDefaults(const{
  //   "showBanner":true,
  //   "bannerText":"Welcome to The App"
  // });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home_Page(),
        'Create':(context)=>Create_Page(),
      },
    ),
  );
}
