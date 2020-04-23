import 'package:dio/dio.dart';
import 'package:homeless/data/constants.dart';
import 'package:homeless/models/loginresponse/loginresponse.dart';
import 'package:homeless/packages.dart';
import 'package:homeless/services/sharePreferenceService.dart';

class UserRepository {
  Dio dio = new Dio();

  Future<LoginResponse> login({
    String username,
    String password,
  }) async {
    Response response = await dio.post(loginEndpoint,
        options: Options(contentType: ContentType('application', 'json')),
        queryParameters: {
          "user": username,
          "password": password,
          "token": "$serverToken"
        });

    LoginResponse loggedInUser = LoginResponse.fromJson(response.data);

    // await sharedPreferenceService.setApiKey(loggedInUser.apiKey);
    // await sharedPreferenceService.setGroup(loggedInUser.group);
    // await sharedPreferenceService.setMemberID(loggedInUser.id);
    // await sharedPreferenceService.setName(loggedInUser.name);

    return loggedInUser;
  }
}

UserRepository userRepo = UserRepository();
