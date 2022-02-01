import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/user/profile.dart';

class Add_Details extends StatefulWidget {
  const Add_Details({Key? key}) : super(key: key);

  @override
  _Add_DetailsState createState() => _Add_DetailsState();
}

class _Add_DetailsState extends State<Add_Details> {
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  var newName = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final newNameController = TextEditingController();

  bool showLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Details"),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: showLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            autofocus: false,
                            //obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Name: ',
                              hintText: 'Enter Name',
                              labelStyle: TextStyle(fontSize: 20.0),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                            ),
                            controller: newNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showLoading = true;
                            });
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                newName = newNameController.text;
                              });
                              changeName();
                            }
                          },
                          child: const Text(
                            'Change Name',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
            ),
          )),
    );
  }

  void changeName() async {
    try {
      await user?.updateDisplayName(newName);
      setState(() {
        showLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.purple,
          content: Text(
            'Your Name has been Changed',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ); } catch (e) {}
  }
}
