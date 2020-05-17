import 'package:homeless/packages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((onValue) {
    sharedPreferenceService.getSharedPreferencesInstance().then((onValue) {
      runApp(MyApp());
    });
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestIOSPermissions();
    initNotifications();
  }

  Future<void> initNotifications() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    Future<dynamic> fcmBackgroundMessageHandler(Map<String, dynamic> message) {
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      var initializationSettingsIOS = new IOSInitializationSettings(
          onDidReceiveLocalNotification: (i, string1, string2, string3) {
        print("received notifications");
      });
      var initializationSettings = new InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (string) {
        print("selected notification");
      });

      if (message.containsKey('data')) {
// Handle data message
        final dynamic data = message['data'];
        print('Background: $data');
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            data, data, data,
            importance: Importance.Max, priority: Priority.High);
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        flutterLocalNotificationsPlugin
            .show(0, data, data, platformChannelSpecifics, payload: data);
      }

      if (message.containsKey('notification')) {
// Handle notification message
        final dynamic notification = message['notification'];
        print('Background: $notification');
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            notification, notification, notification,
            importance: Importance.Max, priority: Priority.High);
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        flutterLocalNotificationsPlugin.show(
            0, notification, notification, platformChannelSpecifics,
            payload: notification);
      }

      return null;
// Or do other work.
    }

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    // For iOS request permission first.
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        await flutterLocalNotificationsPlugin.show(
            0, message['title'], message['body'], platformChannelSpecifics,
            payload: message['payload']);
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
        await flutterLocalNotificationsPlugin.show(
            0, message['title'], message['body'], platformChannelSpecifics,
            payload: message['payload']);

        ///
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        await flutterLocalNotificationsPlugin.show(
            0, message['title'], message['body'], platformChannelSpecifics,
            payload: message['payload']);
      },
    );

    _firebaseMessaging.getToken().then((String token) {});
    String token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
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
        home: OnBoardingScreen(),
        duration: 5000,
        type: AnimatedSplashType.StaticDuration,
      ),
      routes: routes,
    );
  }
}
