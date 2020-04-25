import 'package:homeless/packages.dart';
import 'package:homeless/services/push_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((onValue) {
    sharedPreferenceService.getSharedPreferencesInstance().then((onValue) {
      runApp(MyApp());
    });
  });

  bool _initialized = false;

  if (!_initialized) {
    Future<void> init() async {
      FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

      Future<dynamic> fcmBackgroundMessageHandler(
          Map<String, dynamic> message) {
        if (message.containsKey('data')) {
// Handle data message
          final dynamic data = message['data'];
          print('Background: $data');
        }

        if (message.containsKey('notification')) {
// Handle notification message
          final dynamic notification = message['notification'];
          print('Background: $notification');
        }

        _initialized = true;

        return null;
// Or do other work.
      }

      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
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
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
////          _navigateToItemDetail(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
////          _navigateToItemDetail(message);
        },
      );

      _firebaseMessaging.getToken().then((String token) {});
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Forces the App to only be used in Portrait.
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
        primarySwatch: Colors.grey,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: AnimatedSplash(
        imagePath: 'assets/images/Logo.png',
        home: LoginScreen(),
        duration: 5000,
        type: AnimatedSplashType.StaticDuration,
      ),
      routes: routes,
    );
  }
}
