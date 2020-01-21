import 'package:dio/dio.dart';
import 'package:homeless/data/constants.dart';
import 'package:homeless/model/rewards/rewards.dart';
import 'dart:convert';

class Network {
  Dio dio = Dio();

  Future getData() async {
    Response response = await dio.get(
      rewards_Settings,
      options: Options(
        headers: {
          "X-Public": keyPublic,
        },
        responseType: ResponseType.plain,
      ),
    );

//    var rewards = Rewards.fromJson(response.data);

    Map<dynamic, dynamic> rewardMap = json.decode(response.data);

//    Map<dynamic, dynamic> rewardMap = json.decode(rewards);

    return rewardMap;
  }
}
