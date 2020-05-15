import 'package:homeless/packages.dart';

class InvalidCardWarning extends StatelessWidget {
  const InvalidCardWarning({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text('This is Not a Valid Card'),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, right: 15.0, left: 15.0),
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
          ),
        )
      ],
    );
  }
}
