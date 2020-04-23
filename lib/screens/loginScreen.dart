import 'package:homeless/packages.dart';
import 'package:homeless/services/sharePreferenceService.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static LoginResponse _token;
  bool busyView = false;

  @override
  Widget build(BuildContext context) {
    if (!busyView) {
      return Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Homeless",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 38),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(labelText: "Username"),
                        keyboardType: TextInputType.text,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: "Password"),
                        validator: (value) {
                          return value.length < 4
                              ? "Password must be at least 4 characters long"
                              : null;
                        },
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          letterSpacing: 1,
                          color: AppTheme.nearlyWhite,
                        ),
                      ),
                      textColor: AppTheme.white,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            busyView = true;
                          });

                          _token = await userRepo
                              .login(
                                password: passwordController.text,
                                username: usernameController.text,
                              )
                              .catchError((onError) {});

                          sharedPreferenceService.setApiKey(_token.apiKey);
                          sharedPreferenceService.setGroup(_token.group);
                          sharedPreferenceService.setMemberID(_token.id);
                          sharedPreferenceService.setName(_token.name);

                          if (_token != null) {
                            print('The Set ApiKey: ${_token.apiKey}');
                            ShowToast.showToast("Login Successful", context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
                          } else {
                            setState(() {
                              busyView = false;
                            });
                            ShowToast.showToast("Login Failed", context);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          }
                        }
                      },
                      splashColor: AppTheme.nearlyWhite,
                      color: AppTheme.nearlyBlack,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
