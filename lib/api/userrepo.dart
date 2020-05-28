import 'package:dio/dio.dart';
import 'package:graphql/client.dart';
import 'package:homeless/data/constants.dart';
import 'package:homeless/models/loginresponse/loginresponse.dart';
import 'package:homeless/models/signUp/signupresponse.dart';
import 'package:homeless/packages.dart';
import 'package:homeless/services/sharePreferenceService.dart';

class UserRepository {
  static Dio dio = new Dio(); //Handles Api Calls
  static String apiKey; //ApiKey From Server
  static Future<LoginResponse> login({
    String username,
    String password,
  }) async {
    try {
      //Api Call Response stored in Login Response Model
      Response response = await dio.post(loginEndpoint,
          options: Options(contentType: 'application/json'),
          queryParameters: {
            "user": username,
            "password": password,
            "token": serverToken, //TODO: Not Supposed to be Stored InApp.
          });

      LoginResponse loggedInUser = LoginResponse.fromJson(response.data);

      //Storing Response to SharedPrefs
      sharedPreferenceService.setApiKey(loggedInUser.apiKey);
      sharedPreferenceService.setGroup(loggedInUser.group);
      sharedPreferenceService.setMemberID(loggedInUser.id);
      sharedPreferenceService.setName(loggedInUser.name);
      sharedPreferenceService.setEmail(loggedInUser.email);

      //Get ApiKey from SharedPref and assign it to apiKey variable.
      sharedPreferenceService.getApiKey().then((String value) {
        apiKey = value;
        print('API Key: $value');
      });
      return loggedInUser;
    } on DioError catch (e) {
      //Posssible Responses from server
      if (e.response.statusCode == 401 ||
          e.response == null ||
          e.response.statusCode == 404) {
        print("Dio Error: ${e.response.data}");
        return e.response.data;
      } else {
        print(e.message);
      }
    }
  }

  static Future<SignUpResponse> signUp({
    // user data (user, name, email, active, group)
    String username,
    String name,
    String email,
    String password,
    String group,
  }) async {
    try {
      //Registeration form Data
      var formData = FormData.fromMap({
        'user[user]': username,
        'user[password]': password,
        'user[name]': name,
        'user[email]': email,
        'user[active]': '',
        'user[group]': group,
      });

      //Api Call Response stored in Login Response Model
      var response = await dio.post(signUpEndpoint,
          options: Options(contentType: 'application/json'),
          queryParameters: {
            'token': serverToken, //TODO: Not Supposed to be Stored InApp.
          },
          data: formData);

      SignUpResponse signedUpUser = SignUpResponse.fromJson(response.data);

      print(signedUpUser.active);
      return signedUpUser;
    } on DioError catch (e) {
      //Posssible Responses from server
      print('Dio Error: ${e.response.data}');
      // if (e.response.statusCode == 401 ||
      //     e.response == null ||
      //     e.response.statusCode == 404) {

      //   return e.response.data;
      // } else {
      //   print(e.message);
      // }
    }
  }

  //Attach Logged In Users account access token to the GraphQL Endpoint.
  static final HttpLink _httpLink = HttpLink(
    uri: '$graphQLEndpoint$apiKey',
  );

  //GraphQL Client.
  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: _httpLink,
    ),
  );
}
