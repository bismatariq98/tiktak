// ignore_for_file: non_constant_identifier_names, file_names, unused_local_variable

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<bool> saveCurrentUserID(currentUserID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('UserID', currentUserID);
  }

  Future<String> getCurrentUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserName = prefs.getString('UserID');
    return UserName;
  }

  Future deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
