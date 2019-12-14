import 'package:homeless/packages.dart';
import 'package:flutter_login/flutter_login.dart';

const users = const {
  'pdmgawi@gmail.com': '12345',
};

class LoginScreen extends StatelessWidget {
//  final SharedPreferences prefs;
//  LoginScreen({this.prefs});

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
        primaryColor: AppTheme.dark_grey,
        accentColor: AppTheme.chipBackground,
        errorColor: Colors.deepOrange,
        titleStyle: AppTheme.headline,
        bodyStyle: AppTheme.body1,
        textFieldStyle: AppTheme.subtitle,
        buttonStyle: AppTheme.subtitle,
        cardTheme: CardTheme(
          color: AppTheme.chipBackground,
          elevation: 8,
          margin: EdgeInsets.only(top: 5),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: false,
          fillColor: AppTheme.dark_grey,
          contentPadding: EdgeInsets.all(6.0),
          errorStyle: TextStyle(
            backgroundColor: AppTheme.chipBackground,
            color: AppTheme.darkerText,
          ),
          hintStyle: TextStyle(color: AppTheme.dark_grey),
          focusColor: AppTheme.dark_grey,
          helperStyle: TextStyle(color: AppTheme.darkText),
          labelStyle: TextStyle(fontSize: 18),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.darkerText, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.darkText, width: 2),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 2),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 3),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: AppTheme.dark_grey,
          backgroundColor: AppTheme.nearlyWhite,
          highlightColor: AppTheme.dark_grey,
          elevation: 8.0,
          highlightElevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
//        widget.prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard(),
//          OnBoardingScreen(prefs: prefs),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
