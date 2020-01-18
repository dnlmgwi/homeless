import 'package:dio/dio.dart';
import 'package:homeless/data/constants.dart';
import 'package:homeless/model/rewards/settingsRewards.dart';

class UserRepository {
  Dio dio = Dio();

  Future<List> rewardsCheck() async {
    Response response = await dio.get(
      rewards_Settings,
      options: Options(headers: {
        "X-Public": keyPublic,
      }, responseType: ResponseType.json),
    );

    SettingsRewards currentRewards = SettingsRewards.fromJson(response.data);

    return currentRewards.fields;
  }
}
