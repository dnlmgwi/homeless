import 'package:homeless/packages.dart';
import 'package:homeless/services/push_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((onValue) {
    runApp(MyApp());
  });

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
