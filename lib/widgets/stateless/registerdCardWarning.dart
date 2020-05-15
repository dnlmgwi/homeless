import 'package:homeless/packages.dart';

class RegisteredCardWarning extends StatelessWidget {
  const RegisteredCardWarning({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('This Card Is Registered'),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Text('Try Again'),
            textColor: AppTheme.white,
            onPressed: () {
              Navigator.pop(context);
            },
            splashColor: AppTheme.nearlyWhite,
            color: AppTheme.nearlyBlack,
          ),
        )
      ],
    );
  }
}
