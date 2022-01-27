import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/login.dart';
import 'package:flutter_fb_auth/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              'Reset Link will be sent to your email id !',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Email: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
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
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                });
                               // resetPassword();
                              }
                            },
                            child: Text(
                              'Send Email',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) => Login(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                  (route) => false)
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an Account? "),
                          TextButton(
                              onPressed: () => {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, a, b) =>
                                              Signup(),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                        ),
                                        (route) => false)
                                  },
                              child: Text('Signup'))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
