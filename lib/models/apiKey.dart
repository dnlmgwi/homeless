import 'package:homeless/packages.dart';

class ApiKey {
  String apiKey;

  String getAPIkey() {
    sharedPreferenceService.getApiKey().then((onValue) {
      onValue = apiKey;
    });
    return apiKey;
  }
}
