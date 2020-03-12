import 'package:homeless/packages.dart';

//Contains all in app navigation code.
final routes = {
  '/about': (BuildContext context) => AboutScreen(),
  '/donate': (BuildContext context) => Donate(),
  '/profile': (BuildContext context) => ProfileScreen(),
  '/dash': (BuildContext context) => Dashboard(),
  '/feedback': (BuildContext context) => FeedbackScreen(),
  '/rewards': (BuildContext context) => RewardsScreen(),
  '/news': (BuildContext context) => NewsScreen(),
  '//behaviours': (BuildContext context) => BehavioursScreen(),
  '/terms': (BuildContext context) => TermsScreen(),
  '/logout': (BuildContext context) => OnBoardingScreen(),
  '/share': (BuildContext context) => InviteFriend(),
  '/game': (BuildContext context) => QuizPage(),
//'/login': (BuildContext context) => LoginScreen(),
//'/learn': (BuildContext context) => Learn(),
};
