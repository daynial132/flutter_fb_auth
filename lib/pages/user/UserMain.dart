import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/login.dart';
import 'package:flutter_fb_auth/pages/user/changePassword.dart';
import 'package:flutter_fb_auth/pages/user/dashboard.dart';
import 'package:flutter_fb_auth/pages/user/profile.dart';
import 'package:flutter_fb_auth/theme/thememodel.dart';
import 'package:flutter_fb_auth/widget/navigationdrawerwidget.dart';
import 'package:provider/provider.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    ChangePassword(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                },
                icon: Icon(themeNotifier.isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny))
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Welcome User"),
              // ElevatedButton(
              //   onPressed: () async => {
              //     await FirebaseAuth.instance.signOut(),
              //     Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => Login(),
              //         ),
              //         (route) => false)
              //   },
              //   child: Text('Logout'),
              //   style: ElevatedButton.styleFrom(primary: Colors.purple),
              // ),
            ],
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedFontSize: 10,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Dashboard',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'My Profile',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.settings),
        //       label: 'Change Password',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.brown,
        //   onTap: _onItemTapped,
        // ),
      );
    });
  }
}
