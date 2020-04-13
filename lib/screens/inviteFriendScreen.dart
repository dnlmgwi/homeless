import 'package:flutter_svg/svg.dart';
import 'package:homeless/packages.dart';

class InviteFriend extends StatefulWidget {
  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  void initState() {
    super.initState();
  }

  final String appLink = 'https://ictechhub.com/inventions/';

  shareApp() {
    Share.share('$appLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1.2,
        centerTitle: false,
        backgroundColor: AppTheme.chipBackground,
        title: Text(
          "Share",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: 1.2,
            color: AppTheme.dark_grey,
          ),
        ),
      ),
      backgroundColor: AppTheme.chipBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: SvgPicture.asset(
                  'assets/images/invite-01.svg',
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Invite Your Friends',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: 0.5,
                    color: AppTheme.nearlyBlack,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Lets grow the community of helping hands share the app on your other platforms",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 0.5,
                    color: AppTheme.nearlyBlack,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton.icon(
                  color: AppTheme.dark_grey,
                  onPressed: shareApp,
                  icon: Icon(
                    Icons.share,
                    color: AppTheme.white,
                  ),
                  label: Text(
                    'Share',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontSize: 16,
                      color: AppTheme.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
