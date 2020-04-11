import 'package:homeless/packages.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  void initState() {
    super.initState();
  }

  _launchPrivacy() async {
    const String url = 'http://www.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTerms() async {
    const String url = 'http://www.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.chipBackground,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        titleSpacing: 1.2,
        centerTitle: false,
        backgroundColor: AppTheme.dark_grey,
        title: Text(
          "Privacy",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: 1.2,
            color: AppTheme.nearlyWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 500,
                height: 155,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: SvgPicture.asset('assets/images/helpImage-01.svg'),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'All The Legal Information',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.2,
                    color: AppTheme.deactivatedText,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Knowledge is power read up and know your rights.',
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  letterSpacing: 1.2,
                  color: AppTheme.deactivatedText,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text('Terms of Use'),
                onTap: _launchTerms,
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Privacy Policies'),
                onTap: _launchPrivacy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
