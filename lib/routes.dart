import 'package:homeless/packages.dart';
//Contains all in app navigation code.
final routes = {
  '/about': (BuildContext context) => AboutScreen(),
  '/stats': (BuildContext context) => StatsScreen(),
  '/donate': (BuildContext context) => Donate(), //TODO: Update
  '/dash': (BuildContext context) => Dashboard(),
  '/feedback': (BuildContext context) => FeedbackScreen(),
  '/news': (BuildContext context) => NewsScreen(),
  '/terms': (BuildContext context) => TermsScreen(),
  '/logout': (BuildContext context) => OnBoardingScreen(),
  '/share': (BuildContext context) => InviteFriend(),
  '/transact': (BuildContext context) => TransactScreen(),
  '/scan': (BuildContext context) => ScanScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/register': (BuildContext context) => RegisterScreen(),
};
