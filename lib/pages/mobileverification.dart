import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          title: Text("Phone No. Verification"),
        ),
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }

  getMobileFormWidget(context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Phone Number: ',
              labelStyle: TextStyle(fontSize: 20.0),
              border: OutlineInputBorder(),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
              hintText: "Phone Number", ),
            controller: phoneController),
      ),
    ]);
  }

// return Column(
//   children: [
//     Spacer(),
//     TextField(
//       controller: phoneController,
//       decoration: InputDecoration(
//         hintText: "Phone Number",
//       ),
//     ),
//     SizedBox(
//       height: 16,
//     ),
//     FlatButton(
//       onPressed: () async {
//         setState(() {
//           showLoading = true;
//         });
//
//         await _auth.verifyPhoneNumber(
//           phoneNumber: phoneController.text,
//           verificationCompleted: (phoneAuthCredential) async {
//             setState(() {
//               showLoading = false;
//             });
//             //signInWithPhoneAuthCredential(phoneAuthCredential);
//           },
//           verificationFailed: (verificationFailed) async {
//             setState(() {
//               showLoading = false;
//             });
//             // _scaffoldKey.currentState.showSnackBar(
//             //     SnackBar(content: Text(verificationFailed.message)));
//           },
//           codeSent: (verificationId, resendingToken) async {
//             setState(() {
//               showLoading = false;
//               currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
//               this.verificationId = verificationId;
//             });
//           },
//           codeAutoRetrievalTimeout: (verificationId) async {},
//         );
//       },
//       child: Text("SEND"),
//       color: Colors.blue,
//       textColor: Colors.white,
//     ),
//     Spacer(),
//   ],
// );

  getOtpFormWidget(BuildContext context) {
    return Container();
  }
}
