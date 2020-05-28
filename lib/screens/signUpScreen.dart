import 'package:homeless/models/signUp/newSignUp.dart';
import 'package:homeless/packages.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _signUpMember = SignUpMemberReg();

  final _formKey = GlobalKey<FormState>();
  bool busyView = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!busyView) {
      return Scaffold(
          body: KeyboardAvoider(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Image.asset(
                  //   'assets/images/Logo.png',
                  //   height: 200,
                  // ),
                  Text(
                    "Sign Up".toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      letterSpacing: 1.2,
                      color: AppTheme.darkerText,
                    ),
                  ),
//                 class SignUpMemberReg {
//   String username = '';
//   String name = '';
//   String email = '';
//   String group = '';
// }

                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(
                      children: <Widget>[
                        FormBuilder(
                          key: _fbKey,
                          autovalidate: true,
                          child: Wrap(
                            runSpacing: 10,
                            children: <Widget>[
                              FormBuilderTextField(
                                attribute: "username",
                                decoration:
                                    InputDecoration(labelText: "Username"),
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(2),
                                  FormBuilderValidators.maxLength(70),
                                ],
                                maxLines: 1,
                                onChanged: (value) => setState(
                                    () => _signUpMember.username = value),
                                onSaved: (value) => setState(
                                    () => _signUpMember.username = value),
                              ),
                              FormBuilderTextField(
                                attribute: "Name",
                                decoration: InputDecoration(labelText: "Name"),
                                maxLines: 1,
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(2),
                                  FormBuilderValidators.maxLength(70),
                                ],
                                onChanged: (value) =>
                                    setState(() => _signUpMember.name = value),
                                onSaved: (value) =>
                                    setState(() => _signUpMember.name = value),
                              ),
                              FormBuilderTextField(
                                attribute: "email",
                                decoration: InputDecoration(labelText: "Email"),
                                keyboardType: TextInputType.emailAddress,
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.max(114),
                                  FormBuilderValidators.email(),
                                  FormBuilderValidators.min(18),
                                ],
                                onChanged: (value) =>
                                    setState(() => _signUpMember.email = value),
                                onSaved: (value) =>
                                    setState(() => _signUpMember.email = value),
                              ),
                              FormBuilderTextField(
                                attribute: "password",
                                decoration:
                                    InputDecoration(labelText: "Password"),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                maxLines: 1,
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(4),
                                ],
                                onChanged: (value) => setState(
                                    () => _signUpMember.password = value),
                                onSaved: (value) => setState(
                                    () => _signUpMember.password = value),
                              ),
                              FormBuilderRadio(
                                decoration:
                                    InputDecoration(labelText: "Select Group"),
                                attribute: "group",
                                validators: [FormBuilderValidators.required()],
                                options: [
                                  FormBuilderFieldOption(
                                      value: "Administrator"),
                                  FormBuilderFieldOption(value: "Manager"),
                                ],
                                onChanged: (value) =>
                                    setState(() => _signUpMember.group = value),
                                onSaved: (value) =>
                                    setState(() => _signUpMember.group = value),
                              ),
                              FormBuilderSwitch(
                                  label: Text(ConstantDetails.signUpConsent(
                                      memberName:
                                          "${_signUpMember.name}")), //Attaches Member Name to Consent Agreement
                                  attribute: "consent",
                                  initialValue: false,
                                  validators: [
                                    FormBuilderValidators.requiredTrue()
                                  ],
                                  onChanged: (value) {
                                    setState(
                                        () => _signUpMember.consent = value);
                                  },
                                  onSaved: (value) => setState(
                                      () => _signUpMember.consent = value)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Text(
                          "Register".toUpperCase(),
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
                          if (_fbKey.currentState.saveAndValidate()) {
                            print(_fbKey.currentState.value);
                            setState(() {
                              busyView = true;
                            });
                            var _response = await UserRepository.signUp(
                                    email: _signUpMember.email,
                                    name: _signUpMember.name,
                                    password: _signUpMember.password,
                                    username: _signUpMember.username,
                                    group: _signUpMember.group)
                                .catchError((onError) {
                              ShowToast.showToast(onError, context);
                              print(onError);
                            });

                            if (_response != null) {
                              ShowToast.showToast("SignUp Successful", context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            } else {
                              setState(() {
                                busyView = false;
                              });
                              ShowToast.showToast("SignUp Failed", context);
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
        ),
      ));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
