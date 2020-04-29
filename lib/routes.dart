import 'package:homeless/packages.dart';

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
  '/register': (BuildContext context) => InstructionsScreen(),
  '/scan': (BuildContext context) => ScanScreen(),
  '/share': (BuildContext context) => InviteFriend(),
  '/stats': (BuildContext context) => StatsScreen(),
  '/transact': (BuildContext context) => TransactScreen(),
};
