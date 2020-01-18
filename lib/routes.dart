import 'package:homeless/packages.dart';
import 'package:homeless/screens/rewardspage.dart';

final routes = {
  '/about': (BuildContext context) => AboutScreen(),
  '/donate': (BuildContext context) => Donate(),
//        '/learn': (BuildContext context) => Learn(),
  '/profile': (BuildContext context) => ProfileScreen(),
//        '/login': (BuildContext context) => LoginScreen(),
  '/dash': (BuildContext context) => Dashboard(),
  '/feedback': (BuildContext context) => FeedbackScreen(),
  '/rewards': (BuildContext context) => RewardsScreen(),
  '/terms': (BuildContext context) => TermsScreen(),
  '/logout': (BuildContext context) => OnBoardingScreen(),
  '/share': (BuildContext context) => InviteFriend(),
  '/game': (BuildContext context) => QuizPage(),
};
