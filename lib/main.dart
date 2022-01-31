import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/login.dart';
import 'package:flutter_fb_auth/pages/user/UserMain.dart';
import 'package:flutter_fb_auth/theme/thememodel.dart';
import 'package:flutter_fb_auth/theme/themes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ChangeNotifierProvider(
            create: (_) => ThemeModel(),
            child:
                Consumer(builder: (context, ThemeModel themeNotifier, child) {
              return MaterialApp(
                themeMode: ThemeMode.system,
                // theme: MyThemes.lightTheme,
                theme:
                    themeNotifier.isDark ? MyThemes.darkTheme : MyThemes.lightTheme,
                // darkTheme: MyThemes.darkTheme,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Firebase EMail Password Auth',

                home: const Login(),
              );
            }),
          );
          // return MaterialApp(
          //   title: 'Flutter Firebase EMail Password Auth',
          //   themeMode: ThemeMode.system,
          //   theme: MyThemes.lightTheme,
          //   darkTheme: MyThemes.darkTheme,
          //   // theme: ThemeData(
          //   //   primarySwatch: Colors.deepPurple,
          //   // ),
          //   debugShowCheckedModeBanner: false,
          //   home: Login(),
          // );
        });
  }
}
