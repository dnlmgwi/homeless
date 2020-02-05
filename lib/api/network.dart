import 'package:dio/dio.dart';
import 'package:homeless/data/constants.dart';
import 'dart:convert';

class Network {
  Dio dio = Dio();

  //Fetches Reward Data From The Api
  Future getRewardData() async {
    Response response = await dio.get(
      rewards_Settings,
      options: Options(
        headers: {
          //The Public Key is Constant and in sorted in a separate file.
          "X-Public": keyPublic,
        },
        responseType: ResponseType.plain, //Plain Text is converted into json.
      ),
    );

    Map<dynamic, dynamic> rewardMap = json.decode(response.data);

    return rewardMap; //Returned as a Map<?,?>
  }

  //Fetches Behaviour Data From The Api
  Future getBehaviourData() async {
    Response response = await dio.get(
      behaviour_Settings,
      options: Options(
        headers: {
          //The Public Key is Constant and in sorted in a separate file.
          "X-Public": keyPublic,
        },
        //Plain Text is converted into json.
        responseType: ResponseType.plain,
      ),
    );

    Map<dynamic, dynamic> behaviourMap = json.decode(response.data);

    return behaviourMap; //Returned as a Map<?,?>
  }

  //Fetches isMember From The Api
  Future getIsMember() async {
    Response response = await dio.get(
      rewards_Settings,
      options: Options(
        headers: {
          //The Public Key is Constant and in sorted in a separate file.
          "X-Public": keyPublic,
        },
        responseType: ResponseType.plain, //Plain Text is converted into json.
      ),
    );

    Map<dynamic, dynamic> rewardMap = json.decode(response.data);

    return rewardMap; //Returned as a Map<?,?>
  }

  //Fetches News From The Api
  Future getNews() async {
    Response response = await dio.get(
      news,
      options: Options(
        responseType: ResponseType.json, //Plain Text is converted into json.
      ),
    );

    Map<dynamic, dynamic> newsMap = json.decode(response.data);

    return newsMap; //Returned as a Map<?,?>
  }
}
