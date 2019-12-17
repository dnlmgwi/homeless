//import 'package:homeless/packages.dart';
//import 'package:flutter_login/flutter_login.dart';
//import 'package:dio/dio.dart';
//import 'dart:convert';
//
//class LoginScreen extends StatelessWidget {
////  final SharedPreferences prefs;
////  LoginScreen({this.prefs});
//  final StreamController<AuthenticationState> _streamController;
//
//  LoginScreen(this._streamController);
//
//  Duration get loginTime => Duration(milliseconds: 2250);
//
//  Dio dio = new Dio();
//
//  Future _authUser(LoginData data) async {
//    _streamController.add(AuthenticationState.authenticated());
//    try {
//      String _token = '6ce338b5191c2a121d51b4076b9d72';
//      Response response = await dio.post(
//          "http://sketchdm.co.za/cockpit/api/cockpit/authUser",
//          options: Options(responseType: ResponseType.plain),
//          queryParameters: {
//            "token": "$_token"
//          },
//          data: {
//            "user": data.name,
//            "password": data.password,
//          });
//
//      Map userMap = jsonDecode(response.data);
//
//      var authUser = User.fromJson(userMap);
//
//      print('${authUser.name}');
//
//      return authUser;
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  Future<String> _recoverPassword({name, password}) {
//    print('Name: $name');
//    return Future.delayed(loginTime).then((_) {
//      if (name = true) {
//        return 'Username not exists';
//      }
//      return null;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FlutterLogin(
//      theme: LoginTheme(
//        primaryColor: AppTheme.dark_grey,
//        accentColor: AppTheme.chipBackground,
//        errorColor: Colors.deepOrange,
//        titleStyle: AppTheme.headline,
//        bodyStyle: AppTheme.body1,
//        textFieldStyle: AppTheme.subtitle,
//        buttonStyle: AppTheme.subtitle,
//        cardTheme: CardTheme(
//          color: AppTheme.chipBackground,
//          elevation: 8,
//          margin: EdgeInsets.only(top: 5),
//          shape: ContinuousRectangleBorder(
//              borderRadius: BorderRadius.circular(10.0)),
//        ),
//        inputTheme: InputDecorationTheme(
//          filled: false,
//          fillColor: AppTheme.dark_grey,
//          contentPadding: EdgeInsets.all(6.0),
//          errorStyle: TextStyle(
//            backgroundColor: AppTheme.chipBackground,
//            color: AppTheme.darkerText,
//          ),
//          hintStyle: TextStyle(color: AppTheme.dark_grey),
//          focusColor: AppTheme.dark_grey,
//          helperStyle: TextStyle(color: AppTheme.darkText),
//          labelStyle: TextStyle(fontSize: 18),
//          enabledBorder: UnderlineInputBorder(
//            borderSide: BorderSide(color: AppTheme.darkerText, width: 1),
//          ),
//          focusedBorder: UnderlineInputBorder(
//            borderSide: BorderSide(color: AppTheme.darkText, width: 2),
//          ),
//          errorBorder: UnderlineInputBorder(
//            borderSide: BorderSide(color: Colors.red.shade700, width: 2),
//          ),
//          focusedErrorBorder: UnderlineInputBorder(
//            borderSide: BorderSide(color: Colors.red.shade400, width: 3),
//          ),
//          disabledBorder: UnderlineInputBorder(
//            borderSide: BorderSide(color: Colors.grey, width: 5),
//          ),
//        ),
//        buttonTheme: LoginButtonTheme(
//          splashColor: AppTheme.dark_grey,
//          backgroundColor: AppTheme.nearlyWhite,
//          highlightColor: AppTheme.dark_grey,
//          elevation: 8.0,
//          highlightElevation: 6.0,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(100),
//          ),
//          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
//          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
//        ),
//      ),
//      onLogin: _authUser,
//      onSignup: _authUser,
//      onSubmitAnimationCompleted: () {
////        widget.prefs.setBool('seen', true);
//        Navigator.of(context).pushReplacement(MaterialPageRoute(
//          builder: (context) => Dashboard(),
////          OnBoardingScreen(prefs: prefs),
//        ));
//      },
//      onRecoverPassword: _authUser,
//    );
//  }
//}
