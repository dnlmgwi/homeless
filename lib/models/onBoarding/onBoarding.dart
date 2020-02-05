import 'package:homeless/packages.dart';

class OnBoardingModel {
  final Widget heroAssetPath;
  final String title;
  final String body;
  Widget widget;

  OnBoardingModel({this.heroAssetPath, this.title, this.body, this.widget}) {
    if (widget == null) {
      widget = new Container();
    }
  }

  static List<OnBoardingModel> pages = [
    OnBoardingModel(
      title: 'The Homeless App',
      body:
          'Are you a community member who loves helping the community, use the Homeless app and help remove the less in homeless',
      heroAssetPath: SvgPicture.asset('assets/images/useApp-01.svg'),
    ),
    OnBoardingModel(
      title: 'Need Help?',
      body:
          'Have you got a job that may require small effort for youth, or manual labour for our older beneficiaries.',
      heroAssetPath: SvgPicture.asset('assets/images/work-01.svg'),
    ),
    OnBoardingModel(
      title: 'Security',
      body:
          'Verify registered  beneficiaries of the homeless app by scanning the QR Code on their ID Cards, and reward them for helping you',
      heroAssetPath: SvgPicture.asset('assets/images/Security-01.svg'),
    ),
    OnBoardingModel(
      title: 'Tips & Advice',
      body:
          'Our app will give you access to relavent Tips & Advice about the Homeless community in your area',
      heroAssetPath: SvgPicture.asset('assets/images/advice-01.svg'),
    ),
    OnBoardingModel(
      title: 'Donate',
      body:
          'Or if you just want to give, you can use our in app payment option to donate at any time. and we will use the money we raise to change lives.',
      heroAssetPath: SvgPicture.asset('assets/images/gifts-01.svg'),
    ),
  ];
}
