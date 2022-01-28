import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text(
            'User ID:55', // $uid',
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                'Email: jsndja@gmail.com', //$email',
                style: TextStyle(fontSize: 15.0),
              ),
             // user!.emailVerified
        false          ?
        Text(
                      'verified',
                      style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                    )
                  :TextButton(
                      onPressed: () => {}, // {verifyEmail()},
                      child: Text('Verify Email'))
            ],
          ),
          Text(
            'Created: 10/20/2020', //$creationTime',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
