import 'package:homeless/packages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferences _prefs;

  Future<bool> getSharedPreferencesInstance() async {
    _prefs = await SharedPreferences.getInstance().catchError((e) {
      print("shared prefrences error : $e");
      return false;
    });
    return true;
  }

  Future<bool> setOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', false);
  }

  Future<bool> getOnBoardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool seen = prefs.getBool('seen');
    return seen;
  }

  Future setMemberID(String memberid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('memberid', memberid);
  }

  Future<String> getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString('memberid');
    return memberId;
  }

  Future setApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiKey', apiKey);
  }

  Future<String> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString('apiKey');
    return apiKey;
  }

  Future setGroup(String group) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('group', group);
  }

  Future<String> getGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String group = prefs.getString('group');
    return group;
  }

  Future setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    return name;
  }

  Future clearToken() async {
    await _prefs.clear();
  }
}

SharedPreferenceService sharedPreferenceService = SharedPreferenceService();
