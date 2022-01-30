import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool showLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User SignUp"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: showLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    emailfunction(context),
                    passwordfunction(context),
                    confirmpasswordfunction(context),
                    signupfunction(context),
                    siginfunction(context),
                  ],
                ),
        ),
      ),
    );
  }

  void registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // print(userCredential);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: Colors.redAccent,
        //     content: Text(
        //       "One more Step to GO",
        //       style: TextStyle(fontSize: 20.0),
        //     ),
        //   ),
        // );
        setState(() {
          showLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'network-request-failed') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "A Network Error",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else {
          print(e);
        }
      }
    } else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  passwordfunction(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password: ',
          labelStyle: TextStyle(fontSize: 20.0),
          border: OutlineInputBorder(),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
        ),
        controller: passwordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Password';
          }
          return null;
        },
      ),
    );
  }

  confirmpasswordfunction(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Confirm Password: ',
          labelStyle: TextStyle(fontSize: 20.0),
          border: OutlineInputBorder(),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
        ),
        controller: confirmPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Password';
          }
          return null;
        },
      ),
    );
  }

  emailfunction(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        autofocus: false,
        decoration: const InputDecoration(
          labelText: 'Email: ',
          labelStyle: TextStyle(fontSize: 20.0),
          border: OutlineInputBorder(),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
        ),
        controller: emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Email';
          } else if (!value.contains('@')) {
            return 'Please Enter Valid Email';
          }
          return null;
        },
      ),
    );
  }

  signupfunction(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState!.validate()) {
                setState(() {
                  showLoading = true;
                  email = emailController.text;
                  password = passwordController.text;
                  confirmPassword = confirmPasswordController.text;
                });
                registration();
              }
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

  siginfunction(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an Account? "),
          TextButton(
              onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Login(),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                    )
                  },
              child: const Text('Login'))
        ],
      ),
    );
  }

  nullfunction(BuildContext context) {
    return Container();
  }
}
