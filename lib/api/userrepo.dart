import 'package:dio/dio.dart';
import 'package:graphql/client.dart';
import 'package:homeless/data/constants.dart';
import 'package:homeless/models/loginresponse/loginresponse.dart';
import 'package:homeless/packages.dart';
import 'package:homeless/services/sharePreferenceService.dart';

class UserRepository {
  static Dio dio = new Dio(); //Handle Api Calls
  static String apiKey; //ApiKey From Server
  static Future<LoginResponse> login({
    String username,
    String password,
  }) async {
    try {
      //Api Call Response
      Response response = await dio.post(loginEndpoint,
          options: Options(contentType: ContentType('application', 'json')),
          queryParameters: {
            "user": username,
            "password": password,
            "token": serverToken, //TODO: Not Supposed to be Stored InApp.
          });

      LoginResponse loggedInUser = LoginResponse.fromJson(response.data);

      //Storing Repsonse to SharedPrefs
      sharedPreferenceService.setApiKey(loggedInUser.apiKey);
      sharedPreferenceService.setGroup(loggedInUser.group);
      sharedPreferenceService.setMemberID(loggedInUser.id);
      sharedPreferenceService.setName(loggedInUser.name);

      //Get ApiKey from SharedPref and assign it to apiKey.
      sharedPreferenceService.getApiKey().then((String value) {
        apiKey = value;
      });

      return loggedInUser;
    } on DioError catch (e) {
      if (e.response.statusCode == 401 || e.response == null) {
        print("Dio Error: ${e.response.data}");
        return e.response.data;
      } else {
        print(e.message);
      }
    }
  }

  static final HttpLink _httpLink = HttpLink(
    uri: '$graphQLEndpoint?token=$apiKey',
  );

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: _httpLink,
    ),
  );
}
