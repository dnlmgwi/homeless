import 'package:homeless/packages.dart';
import 'package:homeless/services/push_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  WidgetsFlutterBinding.ensureInitialized();

  @override
  initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        dynamic data = message['data'];
        if (data == null) return;
        String notificationType = data['notification_type'];
//        if (notificationType != null ||
//            notificationType.isEmpty ||
//            notificationType == UIData.notificationForeground) {
//        } else if (notificationType == UIData.notificationInAppDialog) {}
      },
      onBackgroundMessage: fcmBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );

    _firebaseMessaging.getToken().then((String token) {});

//    _firebaseMessaging.subscribeToTopic(UIData.generalTopic);
  }

  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(
      prefs: prefs,
    )); //Shared Preferences allows us to view the onboarding once, and once it is seen it will not be seen again.
  });

//  runApp(MyApp(
//    prefs: prefs,
//  ));
}

Future<dynamic> fcmBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
// Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
// Handle notification message
    final dynamic notification = message['notification'];
  }

  return null;
// Or do other work.
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({this.prefs});

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
      home: AnimatedSplash(
        imagePath: 'assets/images/Logo.png',
        home: _handleCurrentScreen(),
//        OnBoardingScreen(),
        duration: 5000,
        type: AnimatedSplashType.StaticDuration,
      ),
//      Dashboard()
      routes: routes,
    );
  }

  Widget _handleCurrentScreen() {
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      return Dashboard();
    } else {
      return OnBoardingScreen(prefs: prefs);
    }
  }
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
