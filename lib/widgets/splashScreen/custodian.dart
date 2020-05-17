import 'package:homeless/packages.dart';

class Custodian extends StatefulWidget {
  @override
  _CustodianState createState() => _CustodianState();
}

class _CustodianState extends State<Custodian> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'assets/images/Liberty3.png',
      home: OnBoardingScreen(),
      duration: 2500,
      type: AnimatedSplashType.StaticDuration,
    );
  }
}
