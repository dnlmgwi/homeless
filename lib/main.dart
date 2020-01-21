import 'package:homeless/packages.dart';

void main() {
  //Forces the App to only be used in Portrait.
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]).then((_) => SharedPreferences.getInstance().then((prefs) {
//        runApp(MyApp(
//          prefs: prefs,
//        )); //Shared Preferences allows us to view the onboarding once, and once it is seen it will not be seen again.
//      }));

  runApp(MyApp(
//    prefs: prefs,
      ));
}

class MyApp extends StatelessWidget {
//  final SharedPreferences prefs;

  MyApp(
//      {this.prefs}
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: AppTheme.white,
      systemNavigationBarDividerColor: Colors.blue,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Homeless App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: OnBoardingScreen(),
//      Dashboard()
//      _handleCurrentScreen(),
      routes: routes,
    );
  }

//  Widget _handleCurrentScreen() {
//    bool seen = (prefs.getBool('seen') ?? false);
//    if (seen) {
//      return Dashboard();
//    } else {
//      return OnBoardingScreen(prefs: prefs);
//    }
//  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
