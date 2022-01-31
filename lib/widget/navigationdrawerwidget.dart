import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/login.dart';
import 'package:flutter_fb_auth/pages/user/UserMain.dart';
import 'package:flutter_fb_auth/pages/user/profile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
        child: Material(
            color: Color.fromRGBO(132, 53, 163, 1.0),
            child: ListView(children: <Widget>[
              buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                // onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => UserPage(
                //     name: 'Sarah Abs',
                //     urlImage: urlImage,
                //   ),
                // )
                //),
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                   // buildSearchField(),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'Profile',
                      icon: Icons.people,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Cart',
                      icon: Icons.card_travel_rounded,
                      onClicked: () => selectedItem(context, 1),
                    ),

                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Logout',
                      icon: Icons.logout,
                      onClicked: () => selectedItem(context, 2),
                    ),
                  ],
                ),
              ),
            ])));
  }

  selectedItem(BuildContext context, int i) {
    void selectedItem(BuildContext context, int index) {
      Navigator.of(context).pop();

      switch (index) {
        case 0:
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Profile(),
          ));
          break;
        case 4:
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Login(),
          ));
          break;
      }
    }
  }
}

Widget buildHeader({
  required String urlImage,
  required String name,
  required String email,
//  required VoidCallback onClicked,
}) =>
    InkWell(
    //  onTap: onClicked,
      child: Container(
        // padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              child: Icon(Icons.add_comment_outlined, color: Colors.white),
            )
          ],
        ),
      ),
    );

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}
