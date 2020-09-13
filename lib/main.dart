import 'package:dicoding_todo/screens/onboard.dart';
import 'package:dicoding_todo/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_todo/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: kSecondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: routeOnboard(),
    );
  }

  Future<bool> checkFirstOpen() async {
    // init firebase app
    FirebaseApp app = await Firebase.initializeApp();
    print('init firebase app $app');

    // check sharedpreference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_login');
  }

  Widget routeOnboard() {
    return FutureBuilder(
      future: checkFirstOpen(),
      builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot) {
        var data = snapshot.data;
        print('Cheked Data firstOpen $data');
        if (data == false || data == null) {
          return Onboard();
        }
        return Home();
      },
    );
  }
}
