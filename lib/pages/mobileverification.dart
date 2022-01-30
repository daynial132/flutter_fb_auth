import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth/pages/login.dart';
import 'package:flutter_fb_auth/pages/user/UserMain.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone No. Verification"),
      ),
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            child: showLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                    ? getMobileFormWidget(context)
                    : getOtpFormWidget(context),
            padding: const EdgeInsets.all(16),
          ),
          Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Login in with Email'),
            TextButton(
                onPressed: () => {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              Login(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      )
                    },
                child: Text('Switch')),
          ]))
        ],
      ),
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserMain()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      // _scaffoldKey.currentState
      //     .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: false,
            decoration: const InputDecoration(
              labelText: 'Phone Number: ',
              labelStyle: const TextStyle(fontSize: 20.0),
              border: const OutlineInputBorder(),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
              hintText: "Phone Number",
            ),
            controller: phoneController),
      ),
      const SizedBox(
        height: 16,
      ),
      ElevatedButton(
        child: const Text(
          'Send',
          style: TextStyle(fontSize: 18.0),
        ),
        onPressed: () async {
          setState(() {
            showLoading = true;
          });
          await _auth.verifyPhoneNumber(
            phoneNumber: phoneController.text,
            verificationCompleted: (phoneAuthCredential) async {
              setState(() {
                showLoading = false;
              });
              //signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            verificationFailed: (verificationFailed) async {
              setState(() {
                showLoading = false;
              });
              // _scaffoldKey.currentState.showSnackBar(
              //     SnackBar(content: Text(verificationFailed.message)));
            },
            codeSent: (verificationId, resendingToken) async {
              setState(() {
                showLoading = false;
                currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                this.verificationId = verificationId;
              });
            },
            codeAutoRetrievalTimeout: (verificationId) async {},
          );
        },
      )
    ]);
  }

  getOtpFormWidget(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: false,
            decoration: const InputDecoration(
              labelText: 'OTP : ',
              labelStyle: const TextStyle(fontSize: 20.0),
              border: const OutlineInputBorder(),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
              hintText: "OTP No",
            ),
            controller: otpController),
      ),
      const SizedBox(
        height: 16,
      ),
      ElevatedButton(
        child: const Text(
          'Verify',
          style: TextStyle(fontSize: 18.0),
        ),
        onPressed: () async {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otpController.text);
          signInWithPhoneAuthCredential(phoneAuthCredential);
        },
      )
    ]);
  }
}
