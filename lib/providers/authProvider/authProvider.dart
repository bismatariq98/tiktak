import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:tik_tak/main.dart';
import 'package:tik_tak/screens/login_page_widget.dart';
import 'package:tik_tak/theme/tik_tak_theme.dart';

import '../../models/homeModels/userModel.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  userModel userDataID = userModel();

  void _showErrorDialogue(String msg, context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("An Error Occured"),
              content: Text(msg),
              actions: <Widget>[
                FloatingActionButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future<Response> register(String user_email, String user_password,
      String user_name, String user_phone, context) async {
    final Map<String, String> body = {
      'user_email': user_email,
      'user_password': user_password,
      'user_name': user_name,
      'user_phone': user_phone
    };
    final response = await http.post(
        Uri.parse('https://flutterapp.5techsol.com/api/sign_up.php'),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    final isSignedUp = jsonDecode(response.body)['success'];
    if (isSignedUp == "true") {
      await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.topToBottom,
          duration: Duration(milliseconds: 400),
          reverseDuration: Duration(milliseconds: 400),
          child: LoginPageWidget(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Account created successfully',
            style: TikTakTheme.subtitle2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: TikTakTheme.primaryColor,
        ),
      );
    } else {
      _showErrorDialogue(jsonDecode(response.body)['message'], context);
    }
  }

  notify() {
    notifyListeners();
  }

  Future<userModel> login(context) async {
    final Map<String, String> body = {
      'email': 'test@test.com',
      'password': 'test'
    };
    final response = await http.post(
        Uri.parse('https://flutterapp.5techsol.com/api/login.php'),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    if (response.statusCode == 200) {
      userDataID = userModelFromJson(response.body);
      notify();
      final isSignedUp = userDataID.success;
      if (isSignedUp == 'true') {
        await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: 400),
            reverseDuration: Duration(milliseconds: 400),
            child: NavBarPage(initialPage: 'HomePage'),
          ),
          (r) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Welcome back',
              style: TikTakTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: TikTakTheme.primaryColor,
          ),
        );
      }
    } else {
      _showErrorDialogue(jsonDecode(response.body)['message'], context);
    }
  }
}
