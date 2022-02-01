import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/login.dart';
import 'package:flutter_fb_auth/pages/user/add_details.dart';
import 'package:flutter_fb_auth/pages/user/userdel.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final name = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: name == null ? user_route() : user_details(),
      ),
    );
  }

  user_details() {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            '$name',
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
        Center(
          child: Text(
            'Created: $creationTime',
            style: const TextStyle(fontSize: 15.0),
          ),
        ),
        Center(
            child: Column(
          children: [
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 15.0),
            ),
            user!.emailVerified
                ? const Text(
                    'verified',
                    style: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                  )
                : TextButton(
                    onPressed: () => {verifyEmail()},
                    child: const Text('Verify Email'))
          ],
        )),
        ElevatedButton(
          onPressed: () {
            setState(() {

            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Add_Details(),
              ),
            );

          },
          child: const Text(
            'Update Details',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  user_route() {
    try {
      setState(() {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Add_Details(),
        ),
      );
    } catch (e) {}
  }
}
