import 'package:homeless/packages.dart';

GlobalKey globalKey = GlobalKey();
//Contains all in app navigation code.
final routes = {
  '/about': (BuildContext context) => AboutScreen(),
  '/dash': (BuildContext context) => Dashboard(),
  '/donate': (BuildContext context) => Donate(), //TODO: Update
  '/feedback': (BuildContext context) => FeedbackScreen(),
  '/news': (BuildContext context) => NewsScreen(),
  '/terms': (BuildContext context) => TermsScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/logout': (BuildContext context) => OnBoardingScreen(),
  '/instructions': (BuildContext context) => InstructionsScreen(),
  '/register': (BuildContext context) => RegistrationScreen(),
  RegistrationScreen.routeName: (context) => RegistrationScreen(),
  ScanScreen.routeName: (context) => ScanScreen(),
  '/scan': (BuildContext context) => ScanScreen(),
  '/share': (BuildContext context) => InviteFriend(),
  '/stats': (BuildContext context) => StatsScreen(),
  '/transact': (BuildContext context) => TransactScreen(),
};
