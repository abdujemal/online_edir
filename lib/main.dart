
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_edir/firebase_options.dart';
import 'package:online_edir/translation/translations.dart';

import 'View/Pages/LoginSignUp/login_signin_page.dart';
import 'View/Pages/MainPage/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget checkUser(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    if (auth != null) {
      return const MainPage();
    } else {
      return const LogInSignInPage();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Language(),
      debugShowCheckedModeBanner: false,
      title: 'On Edir'.tr,
      locale: const Locale('en', 'EN'),
      theme: ThemeData.dark(),
      home: checkUser(context),
    );
  }
}
