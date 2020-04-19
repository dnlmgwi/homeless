import 'dart:convert';
import 'package:dio/dio.dart';

class HomelessAuth {
  Dio dio = new Dio();

  Future<String> login(String username, String password) async {
    Response response;
    String _token;
    Map credentials = {
      "username": username,
      "password": password,
    };

    response = await dio.post("http://www.sketchdm.co.za/cockpit/auth/login",
        data: jsonEncode(credentials));
    _token = jsonDecode(response.data)["token"];
    return _token;
  }
}

HomelessAuth homelessAuth = HomelessAuth();
