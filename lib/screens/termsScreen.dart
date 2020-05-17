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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.chipBackground,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        titleSpacing: 1.2,
        centerTitle: false,
        backgroundColor: AppTheme.chipBackground,
        title: Text(
          "Privacy",
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 500,
              height: 155,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 16, right: 16),
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
              leading: FaIcon(FontAwesomeIcons.fileContract),
              title: Text('Terms of Use'),
              onTap: ConstantDetails.launchTerms,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.balanceScale),
              title: Text('Privacy Policies'),
              onTap: ConstantDetails.launchPrivacy,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.balanceScale),
              title: Text('EULA Agreements'),
              onTap: ConstantDetails.launchEULA,
            ),
          ],
        ),
      ),
    );
  }
}
