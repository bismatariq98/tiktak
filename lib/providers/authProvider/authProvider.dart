// ignore_for_file: file_names, use_rethrow_when_possible

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:tik_tak/main.dart';
import 'package:tik_tak/models/homeModels/loginResponseModel.dart';
import 'package:tik_tak/providers/sharedPreference.dart';
import 'package:tik_tak/screens/login_page_widget.dart';
import 'package:tik_tak/theme/tik_tak_theme.dart';
import 'dart:convert';

class Authentication with ChangeNotifier {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
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

  Future<Response> signup(String user_email, String user_password,
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
      // await Navigator.pushAndRemoveUntil(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.leftToRight,
      //     duration: Duration(milliseconds: 400),
      //     reverseDuration: Duration(milliseconds: 400),
      //     child: NavBarPage(initialPage: 'HomePage'),
      //   ),
      //   (r) => false,
      // );
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

  Future<void> login(String email, String password, context) async {
    // final Map<String, String> body = {'email': email, 'password': password};
    final Map<String, String> body = {
      'email': 'test@gmail.com',
      'password': 'test'
    };
    final response = await http.post(
        Uri.parse('https://flutterapp.5techsol.com/api/login.php'),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    if (response.statusCode == 200) {
      final loginResponseModel = loginResponseModelFromJson(response.body);
      sharedPreferenceHelper.saveCurrentUserID(loginResponseModel.data.userId);
      final isSignedUp = loginResponseModel.success;
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

        notifyListeners();
        return loginResponseModel;
      }
    } else {
      _showErrorDialogue(jsonDecode(response.body)['message'], context);
    }
  }
}
//ap ny pass kia or save hgya h vo function dkhay jo phly dha rhy thy ?
