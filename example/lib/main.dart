import 'dart:developer';

import 'package:easy_linkedin_login/easy_linkedin_login.dart';
import 'package:flutter/material.dart';

final config = LinkedInConfig(
  clientId: 'YOUR_CLIENT_ID',
  clientSecret: 'YOUR_CLIENT_SECRET',
  redirectUrl: 'YOUR_REDIRECT_URL',
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter LinkedIn demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('LinkedIn Authorization'),
        ),
        body: const LinkedInProfileExamplePage(),
      ),
    );
  }
}

class LinkedInProfileExamplePage extends StatefulWidget {
  const LinkedInProfileExamplePage({super.key});

  @override
  State createState() => _LinkedInProfileExamplePageState();
}

class _LinkedInProfileExamplePageState
    extends State<LinkedInProfileExamplePage> {
  UserObject? user;
  bool logoutUser = false;

  void setUser(LinkedInUserModel u) {
    setState(() {
      user = UserObject(
        firstName: u.givenName ?? 'N/A',
        lastName: u.familyName ?? 'N/A',
        email: u.email ?? 'N/A',
        profileImageUrl: u.picture ?? 'N/A',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          LinkedInStandardButton(
            config: config,
            destroySession: logoutUser,
            onError: (error) => log('Error: ${error.message}'),
            onGetAuthToken: (data) => log('Access token ${data.accessToken!}'),
            onGetUserProfile: setUser,
            mini: true,
          ),
          LinkedInStandardButton(
            config: config,
            destroySession: logoutUser,
            onError: (error) => log('Error: ${error.message}'),
            onGetAuthToken: (data) => log('Access token ${data.accessToken!}'),
            onGetUserProfile: setUser,
          ),
          LinkedInCustomButton(
            config: config,
            destroySession: logoutUser,
            onError: (error) => log('Error: ${error.message}'),
            onGetAuthToken: (data) => log('Access token ${data.accessToken!}'),
            onGetUserProfile: setUser,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              child: Text(
                'Click Here to Login with linkedin',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('First: ${user?.firstName} '),
              Text('Last: ${user?.lastName} '),
              Text('Email: ${user?.email}'),
              Text('Profile image: ${user?.profileImageUrl}'),
            ],
          ),
        ],
      ),
    );
  }
}

class UserObject {
  UserObject(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.profileImageUrl});

  String firstName, lastName, email, profileImageUrl;
}
