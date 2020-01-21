import 'package:homeless/packages.dart';

class OnBoardingModel {
  final String heroAssetPath;
  final String title;
  final String body;
  Widget widget;

  OnBoardingModel({this.heroAssetPath, this.title, this.body, this.widget}) {
    if (widget == null) {
      widget = new Container();
    }
  }
}
